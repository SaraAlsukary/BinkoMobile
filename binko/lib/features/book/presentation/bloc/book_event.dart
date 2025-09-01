// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class GetAllBooksEvent extends BookEvent {}

class GetBooksByCategoryEvent extends BookEvent {
  final int id;

  const GetBooksByCategoryEvent({
    required this.id,
  });
}

class GetBookchaptersEvent extends BookEvent {
  final int id;

  const GetBookchaptersEvent({
    required this.id,
  });
}

class AddBookEvent extends BookEvent {
  final BooksModel book;

  const AddBookEvent(this.book);

  @override
  List<Object> get props => [book];
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
