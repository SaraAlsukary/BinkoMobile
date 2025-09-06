import 'package:binko/core/services/dependecies.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/presentation/bloc/book_bloc.dart';
import 'package:binko/features/book/presentation/pages/book_page.dart';
import 'package:flutter/material.dart';
import 'package:binko/core/extensions/context_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTitleChapterPage extends StatefulWidget {
  final BooksModel book;

  const ShowTitleChapterPage({
    super.key,
    required this.book,
  });

  @override
  State<ShowTitleChapterPage> createState() => _ShowTitleChapterPageState();
}

class _ShowTitleChapterPageState extends State<ShowTitleChapterPage> {
  @override
  void initState() {
    super.initState();
    getIt<BookBloc>().add(GetBookchaptersEvent(id: widget.book.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        backgroundColor: context.primaryColor,
        centerTitle: true,
        title: Text(
          "Chapters",
          style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        bloc: getIt<BookBloc>(),
        builder: (context, state) {
          if (state.chapters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: state.chapters.length,
            itemBuilder: (context, index) {
              final chapter = state.chapters[index];
              return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: context.primaryColor,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    chapter.title ?? "No Title",
                    style: TextStyle(fontSize: 22.sp),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookPage(
                          book: widget.book,
                          initialChapterIndex: index,
                        ),
                      ),
                    );
                  });
            },
          );
        },
      ),
    );
  }
}
