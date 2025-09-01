import 'package:binko/core/services/dependecies.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/presentation/bloc/book_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../home/presentation/widgets/book_widget.dart' show BookWidget;

class MyBookPage extends StatefulWidget {
  const MyBookPage({super.key});

  @override
  State<MyBookPage> createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  late final BookBloc bookBloc;

  @override
  void initState() {
    super.initState();
    bookBloc = getIt<BookBloc>();
    final userId = getIt<AuthBloc>().state.user?.id;
    if (userId != null) {
      bookBloc.add(GetMyBooksEvent(userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Book',
          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
        child: BlocBuilder<BookBloc, BookState>(
          bloc: bookBloc,
          buildWhen: (previous, current) =>
          previous.myBooksStatus != current.myBooksStatus,
          builder: (context, state) {
            if (state.myBooksStatus == RequestStatus.loading) {
              return GridView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 8),
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.6,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, __) =>
                    Skeletonizer(enabled: true, child: BookWidget(book: BooksModel())),
              );
            }

            if (state.myBooksStatus == RequestStatus.success &&
                state.myBooks.isEmpty) {
              return Center(child: Text('error.no_books'.tr()));
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 8),
              itemCount: state.myBooks.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.6,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final book = state.myBooks[index];
                return BookWidget(book: book);
              },
            );
          },
        ),
      ),
    );
  }
}
