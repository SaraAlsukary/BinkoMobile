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
  final List<CommentModel> comments;
  final RequestStatus commentsStatus;
  final RequestStatus addCommentStatus;
  final List<ReplyModel> replies;
  final RequestStatus repliesStatus;
  final RequestStatus addReplyStatus;
  final List<BooksModel> categoryBooks;
  final RequestStatus categoryBooksStatus;

  const BookState({
    this.categoryBooks = const [],
    this.categoryBooksStatus = RequestStatus.init,
    this.replies = const [],
    this.repliesStatus = RequestStatus.init,
    this.addReplyStatus = RequestStatus.init,
    this.comments = const [],
    this.commentsStatus = RequestStatus.init,
    this.addCommentStatus = RequestStatus.init,
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

  BookState copyWith(
      {List<ReplyModel>? replies,
      RequestStatus? repliesStatus,
      RequestStatus? addReplyStatus,
      List<BooksModel>? books,
      List<BooksModel>? myBooks,
      RequestStatus? myBooksStatus,
      List<ChapterModel>? chapters,
      RequestStatus? chapterStatus,
      RequestStatus? addChapterStatus,
      ChapterModel? addedChapter,
      RequestStatus? addBookStatus,
      int? likesCount,
      List<int>? likedBooks,
      List<CommentModel>? comments,
      RequestStatus? commentsStatus,
      RequestStatus? addCommentStatus,
      List<BooksModel>? categoryBooks,
      RequestStatus? categoryBooksStatus}) {
    return BookState(
      categoryBooks: categoryBooks ?? this.categoryBooks,
      categoryBooksStatus: categoryBooksStatus ?? this.categoryBooksStatus,
      replies: replies ?? this.replies,
      repliesStatus: repliesStatus ?? this.repliesStatus,
      addReplyStatus: addReplyStatus ?? this.addReplyStatus,
      books: books ?? this.books,
      myBooks: myBooks ?? this.myBooks,
      myBooksStatus: myBooksStatus ?? this.myBooksStatus,
      chapters: chapters ?? this.chapters,
      chapterStatus: chapterStatus ?? this.chapterStatus,
      addChapterStatus: addChapterStatus ?? this.addChapterStatus,
      addedChapter: addedChapter ?? this.addedChapter,
      addBookStatus: addBookStatus ?? this.addBookStatus,
      likesCount: likesCount ?? this.likesCount,
      likedBooks: likedBooks ?? this.likedBooks,
      comments: comments ?? this.comments,
      commentsStatus: commentsStatus ?? this.commentsStatus,
      addCommentStatus: addCommentStatus ?? this.addCommentStatus,
    );
  }
}
