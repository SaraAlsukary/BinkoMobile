import 'dart:convert';

import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/post_api.dart';
import '../../../../core/unified_api/put_api.dart';
import '../../../../core/utils/type_defs.dart';
import '../models/user_model.dart';

class RemoteAuthDatasource {
  Future<UserModel> login(BodyMap body) async {
    final postApi = PostApi(
        uri: ApiVariables().login(),
        body: body,
        fromJson: (s) {
          return UserModel.fromJson(jsonDecode(s)['user']);
        });
    return await postApi.callRequest();
  }

  Future<UserModel> createUser(BodyMap body) async {
    final postApi = PostApi(
        uri: ApiVariables().createUser(),
        body: body,
        fromJson: (s) {
          return UserModel.fromJson(jsonDecode(s));
        });
    return await postApi.callRequest();
  }

  Future<UserModel> updateProfile(int id, BodyMap body) async {
    final putApi = PutApi(
        uri: ApiVariables().updateProfile(id),
        body: body,
        fromJson: (s) {
          UserModel.fromJson(jsonDecode(s));
        });
    return await putApi.callRequest();
  }
}
