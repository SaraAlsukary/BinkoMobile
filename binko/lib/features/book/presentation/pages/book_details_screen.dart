// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binko/core/extensions/widget_extensions.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_parser.dart';
import '../../../../core/services/dependecies.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../bloc/book_bloc.dart';
import 'book_page.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.book,
  });
  final BooksModel book;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void didChangeDependencies() {
    getIt<BookBloc>().add(GetLikesCount(id: widget.book.id!));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        backgroundColor: context.primaryColor,
        centerTitle: true,
        title: Text(
          'booky',
          style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.edit,
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      body: BlocListener<BookBloc, BookState>(
        bloc: getIt<BookBloc>(),
        listenWhen: (previous, current) =>
            previous.chapters.length != current.chapters.length,
        listener: (context, state) {},
        child: Container(
          width: 1.sw,
          height: 1.sh,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/imgs/background.png',
              ),
            ),
          ),
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  120.verticalSpace,
                  SizedBox(
                    width: .4.sw,
                    height: .25.sh,
                    child: Card(
                      elevation: 8,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.network(
                        ApiVariables().imageUrl(widget.book.image ?? ''),
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    widget.book.name ?? '',
                    style: context.textTheme.titleLarge,
                  ),
                  10.verticalSpace,
                  Text(
                    'Action',
                    style: context.textTheme.titleSmall
                        ?.copyWith(color: Colors.grey),
                  ),
                  10.verticalSpace,
                  Text(
                    widget.book.author?.name ?? 'book.author'.tr(),
                    style: context.textTheme.titleSmall,
                  ),
                  10.verticalSpace,
                  Text(
                    '${'book.publish_date'.tr()}: ${DateFormat('yyyy-MM-dd').format(widget.book.pubDat!)}',
                    style: context.textTheme.titleSmall,
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<BookBloc, BookState>(
                        bloc: getIt<BookBloc>(),
                        builder: (context, state) {
                          return Text(
                            '${'book.likes'.tr()} ${state.likesCount}',
                            style: context.textTheme.titleMedium,
                          );
                        },
                      ),
                      5.horizontalSpace,
                      Assets.assetsSvgsLoveFill.toSvg()
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        bloc: getIt<ProfileBloc>(),
                        builder: (context, state) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(border: Border.all()),
                            child: Row(
                              children: [
                                Text(!state.favoredBooks
                                        .map((e) => e.id)
                                        .contains(widget.book.id)
                                    ? 'Save'
                                    : 'Saved'),
                                10.horizontalSpace,
                                !state.favoredBooks
                                        .map((e) => e.id)
                                        .contains(widget.book.id)
                                    ? Assets.assetsSvgsBookMark.toSvg()
                                    : Assets.assetsSvgsBookMarkGreen.toSvg(),
                              ],
                            ).onTap(() {
                              if (state.favoredBooks
                                  .map((e) => e.id)
                                  .contains(widget.book.id)) {
                                getIt<ProfileBloc>().add(
                                    DeleteFromFavroed(id: widget.book.id!));
                              } else {
                                getIt<ProfileBloc>()
                                    .add(AddToFavroed(booksModel: widget.book));
                              }
                            }),
                          );
                        },
                      ),
                      BlocBuilder<BookBloc, BookState>(
                        bloc: getIt<BookBloc>(),
                        builder: (context, state) {
                          print(state.likedBooks);
                          return Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(border: Border.all()),
                            child: Row(
                              children: [
                                Text('Like'),
                                10.horizontalSpace,
                                state.likedBooks.contains(widget.book.id!)
                                    ? Assets.assetsSvgsLoveFill.toSvg()
                                    : Assets.assetsSvgsLoveNotFill.toSvg(),
                              ],
                            ),
                          );
                        },
                      ).onTap(() {
                        getIt<BookBloc>()
                            .add(ToggleLikeEvent(id: widget.book.id!));
                      }),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return ScaleTransition(
                                scale: animation,
                                child: BookPage(
                                  book: widget.book,
                                ),
                              );
                            },
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(border: Border.all()),
                          child: Row(
                            children: [
                              Text('book.read'.tr()),
                              10.horizontalSpace,
                              Assets.assetsSvgsRead.toSvg(
                                  color: ColorFilter.mode(
                                      context.primaryColor, BlendMode.srcIn)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  25.verticalSpace,
                  Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: context.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'book.summary'.tr(),
                        style: context.textTheme.titleMedium
                            ?.copyWith(color: Colors.white),
                      )),
                  25.verticalSpace,
                  Text(
                    widget.book.description ?? 'book.default_description'.tr(),
                    maxLines: 6,
                    textAlign: TextAlign.justify,
                  ),
                  25.verticalSpace,
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: context.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'book.comments'.tr(),
                            style: context.textTheme.titleMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Spacer(),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.primaryColor.withAlpha(80),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'book.add_comment'.tr(),
                            style: context.textTheme.titleMedium
                                ?.copyWith(color: Colors.white),
                          )),
                    ],
                  ),
                  25.verticalSpace,
                  Text(
                    widget.book.description ?? 'book.default_description'.tr(),
                    maxLines: 6,
                    textAlign: TextAlign.justify,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
