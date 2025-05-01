import 'package:binko/core/error/failures.dart';
import 'package:binko/core/usecase/usecase.dart';
import 'package:binko/features/category/domain/repositories/categories_repository.dart';
import 'package:binko/features/home/data/models/categories_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUsecase
    implements UseCase<List<CategoriesModel>, NoParams> {
  final CategoriesRepository repository;

  GetAllCategoriesUsecase({required this.repository});
  @override
  Future<Either<Failure, List<CategoriesModel>>> call(NoParams params) async {
    return await repository.getAllCategories();
  }
}
