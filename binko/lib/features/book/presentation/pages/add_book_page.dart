import 'dart:io';
import 'package:binko/core/services/dependecies.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/core/widgets/main_button.dart';
import 'package:binko/core/widgets/main_text_field.dart';
import 'package:binko/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/presentation/bloc/book_bloc.dart';
import 'package:binko/features/book/presentation/pages/all_book_page.dart';
import 'package:binko/features/book/presentation/pages/my_book_page.dart';
import 'package:binko/features/category/presentation/bloc/category_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final contentController = TextEditingController();
  final selectedCategoriesNotifier = ValueNotifier<List<int>>([]);
  final isSubmitting = ValueNotifier<bool>(false);
  final selectedLanguageNotifier = ValueNotifier<String>('arabic');
  final pickedImageNotifier = ValueNotifier<File?>(null);

  final picker = ImagePicker();
  bool _hasShownSnack = false;

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

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedImageNotifier.value = File(picked.path);
    }
  }

  void _onAddPressed() {
    final name = nameController.text.trim();
    final desc = descriptionController.text.trim();
    final content = contentController.text.trim();
    final selectedCategories = selectedCategoriesNotifier.value;
    final language = selectedLanguageNotifier.value;
    final imageFile = pickedImageNotifier.value;

    if (name.isEmpty ||
        desc.isEmpty ||
        content.isEmpty ||
        selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('add_book.fill_all'.tr())),
      );
      return;
    }

    final book = BooksModel(
      name: name,
      description: desc,
      content: content,
      categories: selectedCategories.map((e) => e.toString()).toList(),
      language: language,
      pubDat: DateTime.now(),
      author: AuthorModel(id: getIt<AuthBloc>().state.user?.id),
    );

    isSubmitting.value = true;
    if (!bookBloc.isClosed) {
      bookBloc.add(AddBookEvent(book, imageFile));
    }
  }

  @override
  void initState() {
    super.initState();
    categoryBloc.add(GetAllCategoriesEvent());
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    contentController.dispose();
    selectedCategoriesNotifier.dispose();
    isSubmitting.dispose();
    selectedLanguageNotifier.dispose();
    pickedImageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bookBloc,
      child: BlocConsumer<BookBloc, BookState>(
        listener: (context, state) {
          if (state.addBookStatus == RequestStatus.loading) {
            _hasShownSnack = false;
          }
          if (state.addBookStatus == RequestStatus.success && !_hasShownSnack) {
            _hasShownSnack = true;
            isSubmitting.value = false;
            nameController.clear();
            descriptionController.clear();
            contentController.clear();
            selectedCategoriesNotifier.value = [];
            pickedImageNotifier.value = null;
            selectedLanguageNotifier.value = 'arabic';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('add_book.success'.tr())),
            );
          } else if (state.addBookStatus == RequestStatus.failed &&
              !_hasShownSnack) {
            _hasShownSnack = true;
            isSubmitting.value = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('add_book.failed'.tr())),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text('add_book.title'.tr())),
            body: Padding(
              padding: EdgeInsets.all(16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12.h)),
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
                                padding: EdgeInsets.symmetric(vertical: 12.h)),
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
                    ),
                    SizedBox(height: 16.h),
                    MainTextField(
                        controller: nameController, hint: 'add_book.name'.tr()),
                    SizedBox(height: 12.h),
                    MainTextField(
                        controller: descriptionController,
                        hint: 'add_book.description'.tr(),
                        maxLines: 3),
                    SizedBox(height: 12.h),
                    MainTextField(
                        controller: contentController,
                        hint: 'add_book.content'.tr(),
                        maxLines: 5),
                    SizedBox(height: 12.h),
                    BlocBuilder<CategoryBloc, CategoryState>(
                      bloc: categoryBloc,
                      builder: (context, state) {
                        if (state.categories.isEmpty) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                    SizedBox(height: 12.h),
                    ValueListenableBuilder<String>(
                      valueListenable: selectedLanguageNotifier,
                      builder: (context, lang, _) {
                        return DropdownButtonFormField<String>(
                          value: lang,
                          items: const [
                            DropdownMenuItem(
                                value: 'arabic', child: Text('Arabic')),
                            DropdownMenuItem(
                                value: 'english', child: Text('English')),
                          ],
                          onChanged: (v) {
                            if (v != null) selectedLanguageNotifier.value = v;
                          },
                          decoration: InputDecoration(
                            labelText: 'add_book.language'.tr(),
                            border: OutlineInputBorder(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    Center(
                      child: ValueListenableBuilder<File?>(
                        valueListenable: pickedImageNotifier,
                        builder: (context, file, _) {
                          return Column(
                            children: [
                              if (file != null)
                                Image.file(file, height: 120, fit: BoxFit.cover)
                              else
                                Image.asset('assets/imgs/book.png',
                                    height: 120, fit: BoxFit.cover),
                              MainButton(
                                onPressed: _pickImage,
                                text: 'add_book.pick_image'.tr(),
                                width: MediaQuery.of(context).size.width * 0.45,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 25.h),
                    ValueListenableBuilder<bool>(
                      valueListenable: isSubmitting,
                      builder: (context, submitting, _) {
                        return submitting
                            ? Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.blue, size: 50))
                            : MainButton(
                                width: MediaQuery.of(context).size.width * 85,
                                text: 'add_book.submit'.tr(),
                                onPressed: _onAddPressed,
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
