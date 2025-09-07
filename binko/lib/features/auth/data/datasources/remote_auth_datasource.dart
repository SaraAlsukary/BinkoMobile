import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

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



  Future<UserModel> updateProfile(int id, BodyMap body, {File? image}) async {
    try {
      if (image != null) {
        final formData = FormData.fromMap({
          ...body,
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.path.split("/").last,
          ),
        });

        final response = await Dio().put(
          ApiVariables().updateProfile(id).toString(),
          data: formData,
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
            },
          ),
        );


        final decoded = response.data;
        final userJson = (decoded is Map && decoded.containsKey('user'))
            ? decoded['user']
            : decoded;

        return UserModel.fromJson(Map<String, dynamic>.from(userJson));
      } else {

        final putApi = PutApi(
          uri: ApiVariables().updateProfile(id),
          body: body,
          fromJson: (s) {
            print("🔹 Raw response = $s");
            final decoded = jsonDecode(s);

            final userJson = (decoded is Map && decoded.containsKey('user'))
                ? decoded['user']
                : decoded;

            return UserModel.fromJson(Map<String, dynamic>.from(userJson));
          },
        );

        return await putApi.callRequest();
      }
    } catch (e) {
      throw Exception("❌ updateProfile failed: $e");
    }
  }
}
