import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../repositories/books_repo.dart';

@singleton
class AddCommentUsecase {
  final BooksRepo repo;

  AddCommentUsecase(this.repo);

  Future<Either<Failure, void>> call({
    required int userId,
    required int bookId,
    required String comment,
  }) async {
    return await repo.addComment(
      userId: userId,
      bookId: bookId,
      comment: comment,
    );
  }
}
