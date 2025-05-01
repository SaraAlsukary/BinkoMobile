import 'package:binko/core/error/failures.dart';
import 'package:binko/core/unified_api/handling_exception_manager.dart';
import 'package:binko/core/utils/type_defs.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/profile/data/datasources/profile_datasource.dart';
import 'package:dartz/dartz.dart';

class ProfileRepo with HandlingExceptionManager {
  Future<Either<Failure, List<BooksModel>>> getFavoredBooks() async {
    return wrapHandling(tryCall: () async {
      return await ProfileDatasource().getFavoredBooks();
    });
  }

  Future<Either<Failure, void>> addToFavored(int id, int userId) async {
    return wrapHandling(tryCall: () async {
      return await ProfileDatasource().addToFavored(id, userId);
    });
  }

  Future<Either<Failure, void>> deleteFromFavored(int id, int userId) async {
    return wrapHandling(tryCall: () async {
      return await ProfileDatasource().deleteFavored(id, userId);
    });
  }

  Future<Either<Failure, void>> updateProfile(BodyMap body) async {
    return wrapHandling(tryCall: () async {
      return await ProfileDatasource().updateProfile(body);
    });
  }
}
