import 'dart:io';

import 'package:binko/core/usecase/usecase.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/book/data/datasources/books_datasource.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
import 'package:binko/features/book/data/repositories/books_repo__impl.dart';
import 'package:binko/features/book/domain/usecases/add_book_usecase.dart';
import 'package:binko/features/book/domain/usecases/add_chapter_usecase.dart';
import 'package:binko/features/book/domain/usecases/get_all_books_usecase.dart';
import 'package:binko/features/book/domain/usecases/get_book_chapters_usecase.dart';
import 'package:binko/features/book/domain/usecases/get_my_book_usecase.dart';
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

  BookBloc(
    this.addChapterUseCase,
    this.getMyBooksUsecase,
    this.addBookUsecase,
    this.getAllBooksUsecase,
    this.getBookChaptersUsecase,
  ) : super(BookState()) {
    on<GetLikesCount>((event, emit) async {
      final result = await BooksRepoImpl(datasource: RemoteBookDatasource())
          .getLikes(event.id);
      result.fold((left) {}, (right) {
        emit(state.copyWith(likesCount: right));
      });
    });
    on<ToggleLikeEvent>((event, emit) async {
      emit(state.copyWith(
          likesCount: state.likesCount + 1,
          likedBooks: state.likedBooks.contains(event.id)
              ? (List.of(state.likedBooks)..remove(event.id))
              : (List.of(state.likedBooks)..add(event.id))));
      final result = await BooksRepoImpl(datasource: RemoteBookDatasource())
          .addLike(event.id);
      result.fold((left) {
        emit(state.copyWith(
            likesCount: state.likesCount - 1,
            likedBooks: !state.likedBooks.contains(event.id)
                ? (List.of(state.likedBooks)..remove(event.id))
                : (List.of(state.likedBooks)..add(event.id))));
      }, (right) {});
    });
    on<AddBookEvent>((event, emit) async {
      emit(state.copyWith(addBookStatus: RequestStatus.loading));

      final addResult = await addBookUsecase(
        AddBookParams(event.book, event.imageFile),
      );
      final bool addFailed = addResult.fold((l) => true, (r) => false);
      if (addFailed) {
        emit(state.copyWith(addBookStatus: RequestStatus.failed));
        return;
      }
      final allResult = await getAllBooksUsecase(NoParams());
      allResult.fold(
        (f) {
          print('fff $f');
          emit(state.copyWith(addBookStatus: RequestStatus.failed));
        },
        (books) {
          print('booksssssssssssssssssssssss $books');
          emit(state.copyWith(
            books: books,
            addBookStatus: RequestStatus.success,
          ));
        },
      );
    });
    on<GetMyBooksEvent>((event, emit) async {
      emit(state.copyWith(myBooksStatus: RequestStatus.loading));
      final result = await getMyBooksUsecase(event.id);
      result.fold(
        (failure) {
          emit(state.copyWith(myBooksStatus: RequestStatus.failed));
        },
        (books) {
          emit(state.copyWith(
            myBooks: books,
            myBooksStatus: RequestStatus.success,
          ));
        },
      );
    });
    // on<AddChapterEvent>((event, emit) async {
    //   emit(state.copyWith(addChapterStatus: RequestStatus.loading));
    //   final result = await addChapterUseCase(
    //     bookId: event.bookId,
    //     title: event.title,
    //     content: event.content,
    //     audioFile: event.audioFile,
    //   );
    //   result.fold(
    //     (failure) {
    //       emit(state.copyWith(addChapterStatus: RequestStatus.failed));
    //     },
    //     (chapter) {
    //       final updatedChapters = List<ChapterModel>.from(state.chapters)
    //         ..add(chapter);
    //       emit(state.copyWith(
    //         addChapterStatus: RequestStatus.success,
    //         addedChapter: chapter,
    //         chapters: updatedChapters,
    //       ));
    //     },
    //   );
    // });
    on<GetBookchaptersEvent>((event, emit) async {
      emit(state.copyWith(chapterStatus: RequestStatus.loading, chapters: []));
      final result = await getBookChaptersUsecase(event.id);
      result.fold((left) {
        emit(state.copyWith(chapterStatus: RequestStatus.failed));
      }, (right) {
        emit(state.copyWith(
            chapters: right, chapterStatus: RequestStatus.success));
      });
    });
    on<AddChapterEvent>((event, emit) async {
      emit(state.copyWith(addChapterStatus: RequestStatus.loading));
      final result = await addChapterUseCase(
        bookId: event.bookId,
        title: event.title,
        content: event.content,
        audioFile: event.audioFile,
      );
      await result.fold(
        (failure) async {
          emit(state.copyWith(addChapterStatus: RequestStatus.failed));
        },
        (chapter) async {
          emit(state.copyWith(
            addChapterStatus: RequestStatus.success,
            addedChapter: chapter,
          ));

          add(GetBookchaptersEvent(id: event.bookId));
        },
      );
    });
  }
}
