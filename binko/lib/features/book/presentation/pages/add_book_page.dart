import 'dart:async';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/core/widgets/main_button.dart';
import 'package:binko/core/widgets/main_text_field.dart';
import 'package:binko/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/presentation/pages/all_book_page.dart';
import 'package:binko/features/book/presentation/pages/my_book_page.dart';
import 'package:binko/features/category/presentation/bloc/category_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/dependecies.dart';
import '../../../book/presentation/bloc/book_bloc.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final ValueNotifier<List<int>> selectedCategoriesNotifier = ValueNotifier([]);
  final ValueNotifier<bool> isSubmitting = ValueNotifier(false);
  final ValueNotifier<String> viewModeNotifier = ValueNotifier('all');
  StreamSubscription<BookState>? _bookSub;

  CategoryBloc get categoryBloc => getIt<CategoryBloc>();

  BookBloc get bookBloc => getIt<BookBloc>();

  void _toggleCategory(int id) {
    final list = List<int>.from(selectedCategoriesNotifier.value);
    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }
    selectedCategoriesNotifier.value = list;
  }

  void _onAddPressed() {
    final name = nameController.text.trim();
    final desc = descriptionController.text.trim();
    final selected = selectedCategoriesNotifier.value;

    if (name.isEmpty || desc.isEmpty || selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('add_book.fill_all'.tr())),
      );
      return;
    }

    final book = BooksModel(
      name: name,
      description: desc,
      categories: selected.map((e) => e.toString()).toList(),
      pubDat: DateTime.now(),
      author: AuthorModel(id: getIt<AuthBloc>().state.user?.id),
    );

    isSubmitting.value = true;
    bookBloc.add(AddBookEvent(book));
  }

  void _setViewMode(String mode) {
    viewModeNotifier.value = mode;
    if (mode == 'all') {
      bookBloc.add(GetAllBooksEvent());
    } else if (mode == 'mine') {
      bookBloc.add(GetAllBooksEvent());
    }
  }

  @override
  void initState() {
    super.initState();
    categoryBloc.add(GetAllCategoriesEvent());
    _bookSub = bookBloc.stream.listen((state) {
      if (isSubmitting.value && state.addBookStatus != RequestStatus.loading) {
        isSubmitting.value = false;
      }
    });
  }

  @override
  void dispose() {
    _bookSub?.cancel();
    nameController.dispose();
    descriptionController.dispose();
    selectedCategoriesNotifier.dispose();
    isSubmitting.dispose();
    viewModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookBloc, BookState>(
      bloc: bookBloc,
      listener: (context, state) {
        if (state.addBookStatus == RequestStatus.success) {
          nameController.clear();
          descriptionController.clear();
          selectedCategoriesNotifier.value = [];
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('add_book.success'.tr()))
          );
        } else if (state.addBookStatus == RequestStatus.failed) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('add_book.failed'.tr()))
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('add_book.title'.tr()),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder<String>(
                valueListenable: viewModeNotifier,
                builder: (context, mode, _) {
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyBookPage()));
                          },
                          child: Text('My Books'),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllBookPage()));
                          },
                          child: Text('All Books'),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16.h),
              MainTextField(
                  controller: nameController, hint: 'add_book.name'.tr()),
              SizedBox(height: 25.h),
              MainTextField(
                  controller: descriptionController,
                  hint: 'add_book.description'.tr()),
              SizedBox(height: 25.h),
              BlocBuilder<CategoryBloc, CategoryState>(
                bloc: categoryBloc,
                builder: (context, state) {
                  if (state.categories.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ValueListenableBuilder<List<int>>(
                    valueListenable: selectedCategoriesNotifier,
                    builder: (context, selectedList, _) {
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: state.categories.map((cat) {
                          final selected = selectedList.contains(cat.id);
                          return ChoiceChip(
                            label: Text(cat.name ?? ""),
                            selected: selected,
                            onSelected: (_) => _toggleCategory(cat.id!),
                          );
                        }).toList(),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 25.h),
              ValueListenableBuilder<bool>(
                valueListenable: isSubmitting,
                builder: (context, submitting, _) {
                  return MainButton(
                    text: submitting ? "Loading..." : 'add_book.add'.tr(),
                    onPressed: submitting ? null : _onAddPressed,
                    width: MediaQuery.of(context).size.width * 0.9,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
