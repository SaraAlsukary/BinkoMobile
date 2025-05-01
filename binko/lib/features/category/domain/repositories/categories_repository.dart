import 'package:binko/core/error/failures.dart';
import 'package:binko/features/home/data/models/categories_model.dart';
import 'package:dartz/dartz.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoriesModel>>> getAllCategories();
}
