import 'dart:convert';

import 'package:binko/core/unified_api/api_variables.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
import 'package:binko/features/book/data/models/comment_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/dependecies.dart';
import '../../../../core/unified_api/get_api.dart';
import '../../../../core/unified_api/post_api.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

@injectable
class RemoteBookDatasource {
  Future<List<BooksModel>> getAllBooks() async {
    final getApi = GetApi(
        uri: ApiVariables().getAllBooks(),
        fromJson: (s) {
          return List<BooksModel>.from(jsonDecode(s).map((e) {
            return BooksModel.fromJson(e);
          }).toList());
        });
    return await getApi.callRequest();
  }

  Future<int> getLikesCount(int id) async {
    final getApi = GetApi(
        uri: ApiVariables().getLikes(id),
        fromJson: (s) {
          return jsonDecode(s)['likes_count'];
        });
    return await getApi.callRequest();
  }

  Future<List<ChapterModel>> getBookChapters(int id) async {
    final getApi = GetApi(
        uri: ApiVariables().getBookChapters(id),
        fromJson: (s) {
          return List<ChapterModel>.from(jsonDecode(s).map((e) {
            return ChapterModel.fromJson(e);
          }).toList());
        });
    return await getApi.callRequest();
  }

  Future<List<CommentModel>> getComments(BooksModel book) async {
    final getApi = GetApi(
        uri: ApiVariables().getAllComments(),
        fromJson: (s) {
          return List<CommentModel>.from(jsonDecode(s)
              .map((x) {
                return CommentModel.fromJson(x);
              })
              .toList()
              .where((e) => e.book == book.name)
              .toList());
        });
    return await getApi.callRequest();
  }

  Future<void> addLike(int id) async {
    final postApi = PostApi(
        uri: ApiVariables().addLike(id, getIt<AuthBloc>().state.user!.id!),
        body: {},
        fromJson: (s) {});
    return await postApi.callRequest();
  }
}
