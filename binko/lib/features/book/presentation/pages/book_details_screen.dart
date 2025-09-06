import 'package:binko/core/extensions/widget_extensions.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/presentation/pages/add_chapter_page.dart';
import 'package:binko/features/book/presentation/pages/comments_page.dart';
import 'package:binko/features/book/presentation/pages/show_title_chapter_page.dart';
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
import '../../../auth/presentation/bloc/auth_bloc.dart';

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
  bool _isLiking =
      false; // UI-only flag to prevent rapid taps and show progress

  @override
  void didChangeDependencies() {
    getIt<BookBloc>().add(GetLikesCount(id: widget.book.id!));
    super.didChangeDependencies();
  }

  void _openAddCommentSheet(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add Comment", style: context.textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Write your comment...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (controller.text.trim().isEmpty) return;

                  getIt<BookBloc>().add(AddCommentEvent(
                    bookId: widget.book.id!,
                    comment: controller.text.trim(),
                    userId: widget.book.author!.id!,
                  ));

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Comment added ✅")),
                  );
                },
                child:
                    const Text("Send", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
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
          BlocBuilder<AuthBloc, AuthState>(
            bloc: getIt<AuthBloc>(),
            builder: (context, authState) {
              final user = authState.user;
              if (user != null && user.isReader == false) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddChapterPage(
                                  bookId: widget.book.id!,
                                )));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.edit,
                      color: context.theme.colorScheme.onPrimary,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocListener<BookBloc, BookState>(
        bloc: getIt<BookBloc>(),
        // listen when chapters changed OR likes changed (likesCount / likedBooks)
        listenWhen: (previous, current) =>
            previous.chapters.length != current.chapters.length ||
            previous.likesCount != current.likesCount ||
            previous.likedBooks != current.likedBooks,
        listener: (context, state) {
          // When we receive any update from the bloc (chapters or likes),
          // stop the UI liking progress indicator if it was active.
          if (_isLiking) {
            setState(() {
              _isLiking = false;
            });
          }
        },
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
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.error)),
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
                    widget.book.categories?.toString() ?? 'action',
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
                            padding: const EdgeInsets.all(10),
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
                      // Like button container
                      BlocBuilder<BookBloc, BookState>(
                        bloc: getIt<BookBloc>(),
                        builder: (context, state) {
                          final isLiked =
                              state.likedBooks.contains(widget.book.id!);
                          return GestureDetector(
                            onTap: () {
                              if (_isLiking) return; // prevent rapid taps
                              setState(() {
                                _isLiking = true;
                              });
                              getIt<BookBloc>()
                                  .add(ToggleLikeEvent(id: widget.book.id!));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(border: Border.all()),
                              child: Row(
                                children: [
                                  const Text('Like'),
                                  10.horizontalSpace,
                                  // show spinner while processing, otherwise svg icon
                                  if (_isLiking)
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation(
                                              context.primaryColor),
                                        ),
                                      ),
                                    )
                                  else
                                    (isLiked
                                        ? Assets.assetsSvgsLoveFill.toSvg()
                                        : Assets.assetsSvgsLoveNotFill.toSvg()),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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
                          padding: const EdgeInsets.all(10),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowTitleChapterPage(
                            book: widget.book,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: context.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'book.summary'.tr(),
                        style: context.textTheme.titleMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Text(
                    widget.book.description ?? 'book.default_description'.tr(),
                    maxLines: 6,
                    textAlign: TextAlign.justify,
                  ),
                  25.verticalSpace,
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommentsPage(
                                        book: widget.book,
                                      )));
                        },
                        child: Container(
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
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          _openAddCommentSheet(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.primaryColor.withAlpha(80),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'book.add_comment'.tr(),
                              style: context.textTheme.titleMedium,
                            )),
                      ),
                    ],
                  ),
                  25.verticalSpace,
                ],
              )),
        ),
      ),
    );
  }
}
