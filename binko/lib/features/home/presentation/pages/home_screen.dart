import 'package:binko/core/unified_api/api_variables.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/services/dependecies.dart';
import '../../../category/presentation/pages/category_screen.dart';
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
    getIt<HomeBloc>().add(GetHomeBooksEvent());
    getIt<HomeBloc>().add(GetHomeCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Image.asset(Assets.assetsImgsLogo),
      ),
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
                  'Categories',
                  style: context.textTheme.titleLarge,
                ).onTap(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(),
                      ));
                }),
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
                          itemCount:
                              state.categoriesStatus == RequestStatus.loading
                                  ? 6
                                  : state.categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Skeletonizer(
                              ignorePointers: true,
                              enabled: state.categoriesStatus ==
                                  RequestStatus.loading,
                              child: state.categoriesStatus ==
                                      RequestStatus.loading
                                  ? Skeletonizer(
                                      enabled: true,
                                      child: MultiColorBorderContainer(
                                          child: Text('Action')),
                                    )
                                  : MultiColorBorderContainer(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            state.categories[index].name!,
                                            style: context.textTheme.titleLarge,
                                          ).center().expand(),
                                          if (state.categories[index].file !=
                                              null)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                ApiVariables().imageUrl(state
                                                    .categories[index].file!),
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ).expand()
                                        ],
                                      ),
                                    ),
                            );
                          }),
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Famous Books',
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
                    return state.booksStatus == RequestStatus.success &&
                            state.books.isEmpty
                        ? Center(
                            child: Text('There Is No Books Yet'),
                          )
                        : GridView.builder(
                            itemCount:
                                state.booksStatus == RequestStatus.loading
                                    ? 6
                                    : state.books.length,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.6,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return Skeletonizer(
                                  enabled: state.booksStatus ==
                                      RequestStatus.loading,
                                  ignorePointers: true,
                                  child: BookWidget(
                                    book: state.booksStatus ==
                                            RequestStatus.loading
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
      ),
    );
  }
}
