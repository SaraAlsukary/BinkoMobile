import 'package:binko/core/error/failures.dart';
import 'package:binko/core/usecase/usecase.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/domain/repositories/books_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMyBooksUsecase implements UseCase<List<BooksModel>, int> {
  final BooksRepo repo;

  GetMyBooksUsecase({required this.repo});

  @override
  Future<Either<Failure, List<BooksModel>>> call(int id) async {
    return await repo.getMyBook(id);
  }
}
