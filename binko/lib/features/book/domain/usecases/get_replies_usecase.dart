import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/reply_model.dart';
import '../repositories/books_repo.dart';

@injectable
class GetRepliesUsecase implements UseCase<List<ReplyModel>, int> {
  final BooksRepo repo;

  GetRepliesUsecase(this.repo);

  @override
  Future<Either<Failure, List<ReplyModel>>> call(int commentId) async {
    return await repo.getRepliesByCommentId(commentId);
  }
}
