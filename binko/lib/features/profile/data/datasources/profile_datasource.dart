import 'dart:convert';

import 'package:binko/core/services/dependecies.dart';
import 'package:binko/core/unified_api/api_variables.dart';
import 'package:binko/core/unified_api/delete_api.dart';
import 'package:binko/core/utils/type_defs.dart';
import 'package:binko/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:binko/features/book/data/models/books_model.dart';

import '../../../../core/unified_api/get_api.dart';
import '../../../../core/unified_api/post_api.dart';

class ProfileDatasource {
  Future<List<BooksModel>> getFavoredBooks() async {
    final getApi = GetApi(
        uri: ApiVariables().getFavoredBooks(getIt<AuthBloc>().state.user!.id!),
        fromJson: (s) {
          return List<BooksModel>.from(jsonDecode(s).map((e) {
            return BooksModel.fromJson(e);
          }).toList());
        });
    return await getApi.callRequest();
  }

  Future<void> updateProfile(BodyMap body) async {
    final postApi = PostApi(
        uri: ApiVariables().updateProfile(getIt<AuthBloc>().state.user!.id!),
        body: body,
        fromJson: (s) {});
    return await postApi.callRequest();
  }

  Future<void> addToFavored(int id, int userId) async {
    final postApi = PostApi(
        uri: ApiVariables().addToFavored(),
        body: {'user': userId, 'book': id},
        fromJson: (s) {});
    return await postApi.callRequest();
  }

  Future<void> deleteFavored(int id, int userId) async {
    final postApi = DeleteApi(
        uri: ApiVariables().deleteFavored(id, userId), fromJson: (s) {});
    return await postApi.callRequest();
  }
}
