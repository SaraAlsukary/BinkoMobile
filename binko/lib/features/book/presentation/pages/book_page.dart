// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:page_flip/page_flip.dart';

import '../../../../core/services/dependecies.dart';

class BookPage extends StatefulWidget {
  const BookPage({
    super.key,
    required this.book,
  });
  final BooksModel book;
  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final _controller = GlobalKey<PageFlipWidgetState>();
  @override
  void initState() {
    getIt<BookBloc>().add(GetBookchaptersEvent(id: widget.book.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.book.name!),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        bloc: getIt<BookBloc>(),
        builder: (context, state) {
          if (state.chapterStatus != RequestStatus.success) {
            return Center(
              child: state.chapterStatus == RequestStatus.failed
                  ? IconButton.filled(
                      onPressed: () {
                        getIt<BookBloc>()
                            .add(GetBookchaptersEvent(id: widget.book.id!));
                      },
                      icon: Icon(Icons.refresh))
                  : CircularProgressIndicator(),
            );
          } else {
            return PageFlipWidget(children: [
              for (int i = 0; i < state.chapters.length; i++)
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: HtmlWidget(state.chapters[i].content!),
                )
            ]);
          }
        },
      ),
    );
  }
}
