import 'package:binko/core/error/failures.dart';
import 'package:binko/core/unified_api/handling_exception_manager.dart';
import 'package:binko/features/category/data/datasources/categories_datasource.dart';
import 'package:binko/features/category/domain/repositories/categories_repository.dart';
import 'package:binko/features/home/data/models/categories_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRepository)
class CategoriesRepoImpl
    with HandlingExceptionManager
    implements CategoriesRepository {
  final RemoteCategoryDatasource datasource;

  CategoriesRepoImpl({required this.datasource});

  @override
  Future<Either<Failure, List<CategoriesModel>>> getAllCategories() async {
    return wrapHandling(tryCall: () async {
      return await datasource.getAllCategories();
    });
  }

  @override
  Future<Either<Failure, CategoriesModel>> addCategory({
    required String name,
    required String nameArabic,
  }) async {
    return wrapHandling(tryCall: () async {
      return await datasource.addCategory(
        name: name,
        nameArabic: nameArabic,
      );
    });
  }
}
