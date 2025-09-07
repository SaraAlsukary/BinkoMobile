// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class GetAllBooksEvent extends BookEvent {}

class GetBooksByCategoryEvent extends BookEvent {
  final int categoryId;
  const GetBooksByCategoryEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class GetBookchaptersEvent extends BookEvent {
  final int id;

  const GetBookchaptersEvent({
    required this.id,
  });
}

class AddBookEvent extends BookEvent {
  final BooksModel book;
  final File? imageFile;

  const AddBookEvent(this.book, this.imageFile);

  @override
  List<Object> get props => [
        book,
        {imageFile}
      ];
}

class ToggleLikeEvent extends BookEvent {
  final int id;

  const ToggleLikeEvent({
    required this.id,
  });
}

class GetLikesCount extends BookEvent {
  final int id;

  const GetLikesCount({required this.id});
}

class GetMyBooksEvent extends BookEvent {
  final int id;

  const GetMyBooksEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddChapterEvent extends BookEvent {
  final int bookId;
  final String title;
  final String content;
  final File? audioFile;

  const AddChapterEvent({
    required this.bookId,
    required this.title,
    required this.content,
    this.audioFile,
  });

  @override
  List<Object> get props => [bookId, title, content, audioFile ?? ''];
}

class GetCommentsEvent extends BookEvent {
  final int bookId;

  const GetCommentsEvent({required this.bookId});

  @override
  List<Object> get props => [bookId];
}

class AddCommentEvent extends BookEvent {
  final int userId;
  final int bookId;
  final String comment;

  const AddCommentEvent({
    required this.userId,
    required this.bookId,
    required this.comment,
  });

  @override
  List<Object> get props => [userId, bookId, comment];
}

class GetRepliesEvent extends BookEvent {
  final int commentId;

  const GetRepliesEvent({required this.commentId});

  @override
  List<Object> get props => [commentId];
}

class AddReplyEvent extends BookEvent {
  final int userId;
  final int commentId;
  final String content;
  final int? parentId;

  const AddReplyEvent({
    required this.userId,
    required this.commentId,
    required this.content,
    this.parentId,
  });

  @override
  List<Object> get props => [userId, commentId, content, parentId ?? ''];
}
