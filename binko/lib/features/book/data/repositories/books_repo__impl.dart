import 'package:binko/core/error/failures.dart';
import 'package:binko/core/unified_api/handling_exception_manager.dart';
import 'package:binko/features/book/data/datasources/books_datasource.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
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
}
