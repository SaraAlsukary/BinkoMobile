import 'package:binko/core/error/failures.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
import 'package:dartz/dartz.dart';

abstract class BooksRepo {
  Future<Either<Failure, List<BooksModel>>> getAllBooks();
  Future<Either<Failure, void>> addLike(int id);
  Future<Either<Failure, int>> getLikes(int id);
  Future<Either<Failure, List<ChapterModel>>> getBookchapters(int id);
}
