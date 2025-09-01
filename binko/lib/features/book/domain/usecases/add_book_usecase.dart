import 'package:binko/core/error/failures.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/domain/repositories/books_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';

@injectable
class AddBookUsecase implements UseCase<void, BooksModel> {
  final BooksRepo repo;

  AddBookUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(BooksModel params) async {
    return await repo.addBook(params);
  }
}
