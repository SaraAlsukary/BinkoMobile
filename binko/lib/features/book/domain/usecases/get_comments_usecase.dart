import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/comment_model.dart';
import '../repositories/books_repo.dart';

@singleton
class GetCommentsUsecase {
  final BooksRepo repo;
  GetCommentsUsecase(this.repo);

  Future<Either<Failure, List<CommentModel>>> call(int bookId) async {
    return await repo.getCommentsByBookId(bookId);
  }
}