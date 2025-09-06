import 'dart:io';

import 'package:binko/core/services/dependecies.dart';
import 'package:binko/core/usecase/usecase.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
import 'package:binko/features/book/data/models/comment_model.dart';
import 'package:binko/features/book/data/models/reply_model.dart';
import 'package:binko/features/book/domain/repositories/books_repo.dart';
import 'package:binko/features/book/domain/usecases/add_book_usecase.dart';
import 'package:binko/features/book/domain/usecases/add_chapter_usecase.dart';
import 'package:binko/features/book/domain/usecases/add_comments_usecase.dart';
import 'package:binko/features/book/domain/usecases/add_reply_usecase.dart';
import 'package:binko/features/book/domain/usecases/get_all_books_usecase.dart';
import 'package:binko/features/book/domain/usecases/get_book_chapters_usecase.dart';
import 'package:binko/features/book/domain/usecases/get_comments_usecase.dart';
import 'package:binko/features/book/domain/usecases/get_my_book_usecase.dart';
import 'package:binko/features/book/domain/usecases/get_replies_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'book_event.dart';

part 'book_state.dart';

@lazySingleton
class BookBloc extends Bloc<BookEvent, BookState> {
  final GetAllBooksUsecase getAllBooksUsecase;
  final GetBookChaptersUsecase getBookChaptersUsecase;
  final AddBookUsecase addBookUsecase;
  final GetMyBooksUsecase getMyBooksUsecase;
  final AddChapterUseCase addChapterUseCase;
  final AddCommentUsecase addCommentUsecase;
  final GetCommentsUsecase getCommentsUsecase;
  final GetRepliesUsecase getRepliesUsecase;
  final AddReplyUsecase addReplyUsecase;

  BookBloc(
    this.addCommentUsecase,
    this.getCommentsUsecase,
    this.addChapterUseCase,
    this.getMyBooksUsecase,
    this.addBookUsecase,
    this.getAllBooksUsecase,
    this.getBookChaptersUsecase,
    this.getRepliesUsecase,
    this.addReplyUsecase,
  ) : super(BookState()) {
    // ----------------- Likes -----------------
    on<GetLikesCount>((event, emit) async {
      final result = await getIt<BooksRepo>().getLikes(event.id);
      result.fold((left) {}, (right) {
        emit(state.copyWith(likesCount: right));
      });
    });

    on<ToggleLikeEvent>((event, emit) async {
      final originalLikedBooks = List<int>.from(state.likedBooks);
      final originalLikesCount = state.likesCount;

      final currentlyLiked = originalLikedBooks.contains(event.id);
      final willLike = !currentlyLiked;
      final int delta = willLike ? 1 : -1;
      final updatedLikedBooks = List<int>.from(originalLikedBooks);

      if (willLike) {
        updatedLikedBooks.add(event.id);
      } else {
        updatedLikedBooks.remove(event.id);
      }

      emit(state.copyWith(
        likesCount: originalLikesCount + delta,
        likedBooks: updatedLikedBooks,
      ));

      final result = await getIt<BooksRepo>().addLike(event.id);

      result.fold(
        (failure) {
          emit(state.copyWith(
            likesCount: originalLikesCount,
            likedBooks: originalLikedBooks,
          ));
        },
        (_) => add(GetLikesCount(id: event.id)),
      );
    });

    // ----------------- Books -----------------
    on<AddBookEvent>((event, emit) async {
      emit(state.copyWith(addBookStatus: RequestStatus.loading));

      final addResult =
          await addBookUsecase(AddBookParams(event.book, event.imageFile));
      final bool addFailed = addResult.fold((l) => true, (r) => false);

      if (addFailed) {
        emit(state.copyWith(addBookStatus: RequestStatus.failed));
        return;
      }

      final allResult = await getAllBooksUsecase(NoParams());
      allResult.fold(
        (_) => emit(state.copyWith(addBookStatus: RequestStatus.failed)),
        (books) => emit(state.copyWith(
          books: books,
          addBookStatus: RequestStatus.success,
        )),
      );
    });

    on<GetMyBooksEvent>((event, emit) async {
      emit(state.copyWith(myBooksStatus: RequestStatus.loading));
      final result = await getMyBooksUsecase(event.id);
      result.fold(
        (_) => emit(state.copyWith(myBooksStatus: RequestStatus.failed)),
        (books) => emit(state.copyWith(
          myBooks: books,
          myBooksStatus: RequestStatus.success,
        )),
      );
    });

    // ----------------- Chapters -----------------
    on<GetBookchaptersEvent>((event, emit) async {
      emit(state.copyWith(chapterStatus: RequestStatus.loading, chapters: []));
      final result = await getBookChaptersUsecase(event.id);
      result.fold(
        (_) => emit(state.copyWith(chapterStatus: RequestStatus.failed)),
        (chapters) => emit(state.copyWith(
          chapters: chapters,
          chapterStatus: RequestStatus.success,
        )),
      );
    });

    on<AddChapterEvent>((event, emit) async {
      emit(state.copyWith(addChapterStatus: RequestStatus.loading));
      final result = await addChapterUseCase(
        bookId: event.bookId,
        title: event.title,
        content: event.content,
        audioFile: event.audioFile,
      );
      result.fold(
        (_) => emit(state.copyWith(addChapterStatus: RequestStatus.failed)),
        (chapter) {
          emit(state.copyWith(
            addChapterStatus: RequestStatus.success,
            addedChapter: chapter,
          ));
          add(GetBookchaptersEvent(id: event.bookId));
        },
      );
    });

    // ----------------- Comments -----------------
    on<GetCommentsEvent>((event, emit) async {
      emit(state.copyWith(commentsStatus: RequestStatus.loading));
      final result = await getCommentsUsecase(event.bookId);
      result.fold(
        (_) => emit(state.copyWith(commentsStatus: RequestStatus.failed)),
        (comments) => emit(state.copyWith(
          comments: comments,
          commentsStatus: RequestStatus.success,
        )),
      );
    });

    on<AddCommentEvent>((event, emit) async {
      emit(state.copyWith(addCommentStatus: RequestStatus.loading));
      final result = await addCommentUsecase(
        userId: event.userId,
        bookId: event.bookId,
        comment: event.comment,
      );
      result.fold(
        (_) => emit(state.copyWith(addCommentStatus: RequestStatus.failed)),
        (_) {
          emit(state.copyWith(addCommentStatus: RequestStatus.success));
          add(GetCommentsEvent(bookId: event.bookId));
        },
      );
    });

    // ----------------- Replies -----------------
    on<GetRepliesEvent>((event, emit) async {
      emit(state.copyWith(repliesStatus: RequestStatus.loading));
      final result = await getRepliesUsecase(event.commentId);
      result.fold(
        (_) => emit(state.copyWith(repliesStatus: RequestStatus.failed)),
        (replies) => emit(state.copyWith(
          replies: replies,
          repliesStatus: RequestStatus.success,
        )),
      );
    });

    on<AddReplyEvent>((event, emit) async {
      emit(state.copyWith(addReplyStatus: RequestStatus.loading));
      final result = await addReplyUsecase(AddReplyParams(
        userId: event.userId,
        commentId: event.commentId,
        content: event.content,
        parentId: event.parentId,
      ));
      result.fold(
        (_) => emit(state.copyWith(addReplyStatus: RequestStatus.failed)),
        (_) {
          emit(state.copyWith(addReplyStatus: RequestStatus.success));
          add(GetRepliesEvent(commentId: event.commentId));
        },
      );
    });
  }
}
