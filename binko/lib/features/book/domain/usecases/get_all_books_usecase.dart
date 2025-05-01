import 'package:binko/core/error/failures.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/domain/repositories/books_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';

@injectable
class GetAllBooksUsecase implements UseCase<List<BooksModel>, NoParams> {
  final BooksRepo repo;

  GetAllBooksUsecase({required this.repo});
  @override
  Future<Either<Failure, List<BooksModel>>> call(NoParams params) async {
    return await repo.getAllBooks();
  }
}
