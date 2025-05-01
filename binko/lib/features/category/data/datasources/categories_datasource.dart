import 'dart:convert';

import 'package:binko/core/unified_api/api_variables.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/get_api.dart';
import '../../../home/data/models/categories_model.dart';

@injectable
class RemoteCategoryDatasource {
  Future<List<CategoriesModel>> getAllCategories() async {
    final getApi = GetApi(
        uri: ApiVariables().getAllCategories(),
        fromJson: (s) {
          return List<CategoriesModel>.from(
              jsonDecode(s).map((e) => CategoriesModel.fromJson(e)).toList());
        });
    return await getApi.callRequest();
  }
}
