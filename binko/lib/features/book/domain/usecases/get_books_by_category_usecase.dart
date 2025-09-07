import 'package:binko/features/book/domain/repositories/books_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/books_model.dart';

class GetBooksByCategoryParams {
  final int categoryId;

  GetBooksByCategoryParams(this.categoryId);
}

@lazySingleton
class GetBooksByCategoryUsecase
    implements UseCase<List<BooksModel>, GetBooksByCategoryParams> {
  final BooksRepo repository;

  GetBooksByCategoryUsecase(this.repository);

  @override
  Future<Either<Failure, List<BooksModel>>> call(
      GetBooksByCategoryParams params) {
    return repository.getBooksByCategory(params.categoryId);
  }
}
