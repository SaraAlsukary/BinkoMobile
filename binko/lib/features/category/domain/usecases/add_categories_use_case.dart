import 'package:binko/core/error/failures.dart';
import 'package:binko/core/usecase/usecase.dart';
import 'package:binko/features/category/domain/repositories/categories_repository.dart';
import 'package:binko/features/home/data/models/categories_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

class AddCategoryParams {
  final String name;
  final String nameArabic;

  AddCategoryParams({
    required this.name,
    required this.nameArabic,
  });
}

@injectable
class AddCategoryUsecase
    implements UseCase<CategoriesModel, AddCategoryParams> {
  final CategoriesRepository repository;

  AddCategoryUsecase(this.repository);

  @override
  Future<Either<Failure, CategoriesModel>> call(
      AddCategoryParams params) async {
    print(
        "Adding category with name: ${params.name}, nameArabic: ${params.nameArabic}");
    final result = await repository.addCategory(
      name: params.name,
      nameArabic: params.nameArabic,
    );
    print("Add category result: $result");
    return result;
  }
}
