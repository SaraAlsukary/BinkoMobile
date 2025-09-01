import 'dart:convert';

import 'package:binko/core/unified_api/api_variables.dart';
import 'package:http/http.dart' as http;
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

  Future<CategoriesModel> addCategory({
    required String name,
    required String nameArabic,
  }) async {
    const fixedFilePath = 'assets/imgs/book.png';
    final url = ApiVariables().addCategory();
    final request = http.MultipartRequest('POST', url)
      ..fields['name'] = name
      ..fields['name_arabic'] = nameArabic;
    // ..files.add(await http.MultipartFile.fromPath('file', fixedFilePath));
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 201) {
      return CategoriesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add category: ${response.body}');
    }
  }
}
