import 'dart:io';

import 'package:binko/core/error/failures.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/domain/repositories/books_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';

@injectable
class AddBookUsecase implements UseCase<void, AddBookParams> {
  final BooksRepo repo;

  AddBookUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(AddBookParams params) async {
    return await repo.addBook(params.book, params.imageFile);
  }
}

class AddBookParams {
  final BooksModel book;
  final File? imageFile;

  AddBookParams(this.book, this.imageFile);
}