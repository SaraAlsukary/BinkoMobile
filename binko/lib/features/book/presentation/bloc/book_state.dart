// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'book_bloc.dart';

class BookState {
  final List<BooksModel> books;
  final List<ChapterModel> chapters;
  final RequestStatus chapterStatus;
  final List<int> likedBooks;
  final int likesCount;
  final List<BooksModel> myBooks;
  final RequestStatus myBooksStatus;
  final RequestStatus addBookStatus;
  final RequestStatus addChapterStatus;
  final ChapterModel? addedChapter;

  BookState({
    this.myBooks = const [],
    this.books = const [],
    this.chapters = const [],
    this.likedBooks = const [],
    this.myBooksStatus = RequestStatus.init,
    this.chapterStatus = RequestStatus.init,
    this.addBookStatus = RequestStatus.init,
    this.addChapterStatus = RequestStatus.init,
    this.likesCount = 0,
    this.addedChapter,
  });

  BookState copyWith({
    List<BooksModel>? books,
    List<ChapterModel>? chapters,
    RequestStatus? chapterStatus,
    List<int>? likedBooks,
    int? likesCount,
    RequestStatus? addBookStatus,
    List<BooksModel>? myBooks,
    RequestStatus? myBooksStatus,
    RequestStatus? addChapterStatus,
    ChapterModel? addedChapter,
  }) {
    return BookState(
      books: books ?? this.books,
      chapters: chapters ?? this.chapters,
      chapterStatus: chapterStatus ?? this.chapterStatus,
      likedBooks: likedBooks ?? this.likedBooks,
      likesCount: likesCount ?? this.likesCount,
      myBooks: myBooks ?? this.myBooks,
      myBooksStatus: myBooksStatus ?? this.myBooksStatus,
      addBookStatus: addBookStatus ?? this.addBookStatus,
      addChapterStatus: addChapterStatus ?? this.addChapterStatus,
      addedChapter: addedChapter ?? this.addedChapter,
    );
  }
}
