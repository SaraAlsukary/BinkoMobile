// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/book/data/datasources/books_datasource.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
import 'package:binko/features/book/data/repositories/books_repo__impl.dart';
import 'package:binko/features/book/domain/usecases/get_all_books_usecase.dart';
import 'package:binko/features/book/domain/usecases/get_book_chapters_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'book_event.dart';
part 'book_state.dart';

@lazySingleton
class BookBloc extends Bloc<BookEvent, BookState> {
  final GetAllBooksUsecase getAllBooksUsecase;
  final GetBookChaptersUsecase getBookChaptersUsecase;
  BookBloc(
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
  }
}
