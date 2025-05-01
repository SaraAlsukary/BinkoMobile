// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'book_bloc.dart';

class BookState {
  final List<ChapterModel> chapters;
  final RequestStatus chapterStatus;
  final List<int> likedBooks;
  final int likesCount;
  BookState({
    this.chapters = const [],
    this.chapterStatus = RequestStatus.init,
    this.likedBooks = const [],
    this.likesCount = 0,
  });

  BookState copyWith({
    List<ChapterModel>? chapters,
    RequestStatus? chapterStatus,
    List<int>? likedBooks,
    int? likesCount,
  }) {
    return BookState(
      chapters: chapters ?? this.chapters,
      chapterStatus: chapterStatus ?? this.chapterStatus,
      likedBooks: likedBooks ?? this.likedBooks,
      likesCount: likesCount ?? this.likesCount,
    );
  }
}
