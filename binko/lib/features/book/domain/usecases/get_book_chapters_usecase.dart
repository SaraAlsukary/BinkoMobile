import 'package:binko/core/error/failures.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
import 'package:binko/features/book/domain/repositories/books_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';

@injectable
class GetBookChaptersUsecase implements UseCase<List<ChapterModel>, int> {
  final BooksRepo repo;

  GetBookChaptersUsecase({required this.repo});
  @override
  Future<Either<Failure, List<ChapterModel>>> call(int params) async {
    return await repo.getBookchapters(params);
  }
}
