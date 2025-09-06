import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/books_repo.dart';

class AddReplyParams {
  final int userId;
  final int commentId;
  final String content;
  final int? parentId;

  AddReplyParams({
    required this.userId,
    required this.commentId,
    required this.content,
    this.parentId,
  });
}

@injectable
class AddReplyUsecase implements UseCase<void, AddReplyParams> {
  final BooksRepo repo;

  AddReplyUsecase(this.repo);

  @override
  Future<Either<Failure, void>> call(AddReplyParams params) async {
    return await repo.addReply(
      userId: params.userId,
      commentId: params.commentId,
      content: params.content,
      parentId: params.parentId,
    );
  }
}
