import 'package:binko/features/book/presentation/bloc/book_bloc.dart';
import 'package:binko/features/home/presentation/widgets/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/services/dependecies.dart';
import '../../../../core/utils/request_status.dart';

class CategoryBooksScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryBooksScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<CategoryBooksScreen> createState() => _CategoryBooksScreenState();
}

class _CategoryBooksScreenState extends State<CategoryBooksScreen> {
  @override
  void initState() {
    super.initState();

    getIt<BookBloc>()
        .add(GetBooksByCategoryEvent(categoryId: widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        bloc: getIt<BookBloc>(),
        builder: (context, state) {

          if (state.categoryBooksStatus == RequestStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }


          if (state.categoryBooksStatus == RequestStatus.failed) {
            return Center(child: Text('error.failed_load_books'.tr()));
          }


          if (state.categoryBooks.isEmpty) {
            return Center(child: Text('error.no_books'.tr()));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: state.categoryBooks.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, i) =>
                BookWidget(book: state.categoryBooks[i]),
          );
        },
      ),
    );
  }
}
