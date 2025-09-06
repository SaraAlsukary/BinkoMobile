import 'dart:io';

import 'package:binko/core/error/failures.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
import 'package:binko/features/book/data/models/comment_model.dart';
import 'package:binko/features/book/data/models/reply_model.dart';
import 'package:dartz/dartz.dart';

abstract class BooksRepo {
  Future<Either<Failure, List<BooksModel>>> getAllBooks();

  Future<Either<Failure, void>> addLike(int id);

  Future<Either<Failure, void>> addBook(BooksModel book,[File? imageFile]);

  Future<Either<Failure, int>> getLikes(int id);

  Future<Either<Failure, List<BooksModel>>> getMyBook(int id);

  Future<Either<Failure, List<ChapterModel>>> getBookchapters(int id);

  Future<Either<Failure, ChapterModel>> addChapter({
    required int bookId,
    String? title,
    String? content,
    File? audioFile,
  });

  Future<Either<Failure, List<CommentModel>>> getCommentsByBookId(int bookId);

  Future<Either<Failure, void>> addComment({
    required int userId,
    required int bookId,
    required String comment,
  });

  Future<Either<Failure, List<ReplyModel>>> getRepliesByCommentId(int commentId);

  Future<Either<Failure, void>> addReply({
    required int userId,
    required int commentId,
    required String content,
    int? parentId,
  });

}
