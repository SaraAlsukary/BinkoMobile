import 'package:binko/core/unified_api/api_variables.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/services/dependecies.dart';
import '../../../category/presentation/pages/category_books_page.dart';
import '../bloc/home_bloc.dart';
import '../widgets/book_widget.dart';
import '../widgets/container_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getIt<HomeBloc>().add(GetHomeBooksEvent());
    getIt<HomeBloc>().add(GetHomeCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0).copyWith(top: 20),
        child: RefreshIndicator.adaptive(
          onRefresh: () {
            getIt<HomeBloc>().add(GetHomeBooksEvent());
            getIt<HomeBloc>().add(GetHomeCategoriesEvent());
            return Future.value();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Text(
                  'home.categories'.tr(),
                  style: context.textTheme.titleLarge,
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<HomeBloc, HomeState>(
                  bloc: getIt<HomeBloc>(),
                  buildWhen: (previous, current) =>
                  previous.categoriesStatus != current.categoriesStatus,
                  builder: (context, state) {
                    return SizedBox(
                      height: .12.sh,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categoriesStatus == RequestStatus.loading
                            ? 6
                            : state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categoriesStatus == RequestStatus.loading
                              ? null
                              : state.categories[index];

                          return Skeletonizer(
                            ignorePointers: true,
                            enabled: state.categoriesStatus == RequestStatus.loading,
                            child: GestureDetector(
                              onTap: state.categoriesStatus == RequestStatus.loading
                                  ? null
                                  : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CategoryBooksScreen(
                                      categoryId: category!.id!,
                                      categoryName: category.name!,
                                    ),
                                  ),
                                );
                              },
                              child: state.categoriesStatus == RequestStatus.loading
                                  ? Skeletonizer(
                                enabled: true,
                                child: MultiColorBorderContainer(
                                  child: Text('home.action'.tr()),
                                ),
                              )
                                  : MultiColorBorderContainer(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      category!.name!,
                                      style: context.textTheme.titleLarge,
                                    ).center().expand(),
                                    if (category.file != null)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          ApiVariables().imageUrl(category.file!),
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ).expand(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'home.famous_books'.tr(),
                    style: context.textTheme.titleLarge,
                  ),
                ),
              ),
              SliverFillRemaining(
                child: BlocBuilder<HomeBloc, HomeState>(
                  bloc: getIt<HomeBloc>(),
                  buildWhen: (previous, current) =>
                  previous.booksStatus != current.booksStatus,
                  builder: (context, state) {
                    if (state.booksStatus == RequestStatus.loading) {
                      return GridView.builder(
                        itemCount: 6,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.6,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) => Skeletonizer(
                          enabled: true,
                          child: BookWidget(book: BooksModel()),
                        ),
                      );
                    }

                    if (state.booksStatus == RequestStatus.success && state.books.isEmpty) {
                      return Center(
                        child: Text('error.no_books'.tr()),
                      );
                    }

                    return GridView.builder(
                      itemCount: state.books.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.6,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) => BookWidget(book: state.books[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
