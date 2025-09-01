import 'package:binko/core/services/dependecies.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/home/presentation/bloc/home_bloc.dart';
import 'package:binko/features/home/presentation/widgets/book_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllBookPage extends StatefulWidget {
  const AllBookPage({super.key});

  @override
  State<AllBookPage> createState() => _AllBookPageState();
}

class _AllBookPageState extends State<AllBookPage> {
  @override
  void initState() {
    getIt<HomeBloc>().add(GetHomeBooksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Book',
          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 8,
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                bloc: getIt<HomeBloc>(),
                buildWhen: (previous, current) =>
                    previous.booksStatus != current.booksStatus,
                builder: (context, state) {
                  return state.booksStatus == RequestStatus.success &&
                          state.books.isEmpty
                      ? Center(
                          child: Text('error.no_books'.tr()),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: state.booksStatus == RequestStatus.loading
                              ? 6
                              : state.books.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.6,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return Skeletonizer(
                                enabled:
                                    state.booksStatus == RequestStatus.loading,
                                ignorePointers: true,
                                child: BookWidget(
                                  book:
                                      state.booksStatus == RequestStatus.loading
                                          ? BooksModel()
                                          : state.books[index],
                                ));
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
