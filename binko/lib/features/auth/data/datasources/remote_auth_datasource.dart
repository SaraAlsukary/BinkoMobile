import 'dart:convert';

import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/post_api.dart';
import '../../../../core/unified_api/put_api.dart';
import '../../../../core/utils/type_defs.dart';
import '../models/user_model.dart';

class RemoteAuthDatasource {
  Future<UserModel> login(BodyMap body) async {
    final postApi = PostApi(
      uri: Uri.parse('http://10.0.2.2:8000/api/login/'),
      body: {"username": body['username'], "password": body['password']},
      fromJson: (s) => UserModel.fromJson(jsonDecode(s)['user']),
    );
    return await postApi.callRequest();
  }

  Future<UserModel> createUser(BodyMap body) async {
    final requestBody = {
      "name": body['name'],
      "username": body['username'],
      "password": body['password'],
      "confirm_password": body['confirmPassword'],
    };
    final postApi = PostApi(
        uri: ApiVariables().createUser(),
        body: requestBody,
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
        try {
          final decoded = jsonDecode(s);

          final userJson = (decoded is Map && decoded.containsKey('user'))
              ? decoded['user']
              : decoded;
          return UserModel.fromJson(Map<String, dynamic>.from(userJson));
        } catch (e) {
          throw Exception(
              'Failed to parse updateProfile response: $e -- raw: $s');
        }
      },
    );

    return await putApi.callRequest();
  }
}
