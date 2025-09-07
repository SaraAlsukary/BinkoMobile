import 'dart:io';

import 'package:binko/core/error/failures.dart';
import 'package:binko/core/unified_api/handling_exception_manager.dart';
import 'package:binko/features/book/data/datasources/books_datasource.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
import 'package:binko/features/book/data/models/comment_model.dart';
import 'package:binko/features/book/data/models/reply_model.dart';
import 'package:binko/features/book/domain/repositories/books_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BooksRepo)
class BooksRepoImpl with HandlingExceptionManager implements BooksRepo {
  final RemoteBookDatasource datasource;

  BooksRepoImpl({required this.datasource});

  @override
  Future<Either<Failure, List<BooksModel>>> getAllBooks() async {
    return wrapHandling(tryCall: () async {
      return await datasource.getAllBooks();
    });
  }

  @override
  Future<Either<Failure, List<ChapterModel>>> getBookchapters(int id) async {
    return wrapHandling(tryCall: () async {
      return await datasource.getBookChapters(id);
    });
  }

  @override
  Future<Either<Failure, void>> addLike(int id) async {
    return wrapHandling(tryCall: () async {
      return await datasource.addLike(id);
    });
  }

  @override
  Future<Either<Failure, int>> getLikes(int id) async {
    return wrapHandling(tryCall: () async {
      return await datasource.getLikesCount(id);
    });
  }

  @override
  Future<Either<Failure, void>> addBook(BooksModel book, [File? imageFile]) {
    return wrapHandling(tryCall: () async {
      return await datasource.addBook(book, imageFile: imageFile);
    });
  }

  @override
  Future<Either<Failure, List<BooksModel>>> getMyBook(int id) {
    return wrapHandling(tryCall: () async {
      return await datasource.getMyBooks(id);
    });
  }

  @override
  Future<Either<Failure, ChapterModel>> addChapter({
    required int bookId,
    String? title,
    String? content,
    File? audioFile,
  }) {
    return wrapHandling(tryCall: () async {
      return await datasource.addChapter(
        bookId: bookId,
        title: title,
        content: content,
        audioFile: audioFile,
      );
    });
  }

  @override
  Future<Either<Failure, void>> addComment({
    required int userId,
    required int bookId,
    required String comment,
  }) {
    return wrapHandling(tryCall: () async {
      return await datasource.addComment(
        userId: userId,
        bookId: bookId,
        comment: comment,
      );
    });
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getCommentsByBookId(int bookId) {
    return wrapHandling(tryCall: () async {
      return await datasource.getCommentsByBookId(bookId);
    });
  }

  @override
  Future<Either<Failure, List<ReplyModel>>> getRepliesByCommentId(
      int commentId) {
    return wrapHandling(tryCall: () async {
      return await datasource.getRepliesByCommentId(commentId);
    });
  }

  @override
  Future<Either<Failure, void>> addReply({
    required int userId,
    required int commentId,
    required String content,
    int? parentId,
  }) {
    return wrapHandling(tryCall: () async {
      return await datasource.addReply(
        userId: userId,
        commentId: commentId,
        content: content,
        parentId: parentId,
      );
    });
  }

  @override
  Future<Either<Failure, List<BooksModel>>> getBooksByCategory(int categoryId) {
    return wrapHandling(tryCall: () async {
      return await datasource.getBooksByCategory(categoryId);
    });
  }
}
