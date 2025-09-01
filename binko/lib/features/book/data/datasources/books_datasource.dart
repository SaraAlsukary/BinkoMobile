import 'dart:convert';
import 'dart:io';

import 'package:binko/core/error/exceptions.dart';
import 'package:binko/core/unified_api/api_variables.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
import 'package:binko/features/book/data/models/comment_model.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
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

  Future<List<BooksModel>> getMyBooks(int id) async {
    final getApi = GetApi(
        uri: ApiVariables().getMyBooks(id),
        fromJson: (s) {
          print(ApiVariables().getMyBooks(6).toString());
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

  Future<void> addBook(BooksModel book, {File? imageFile}) async {
    final uri = ApiVariables().addBook(book.author?.id ?? 0); // already Uri
    final request = http.MultipartRequest('POST', uri);

    if (book.name != null) request.fields['name'] = book.name!;
    if (book.description != null)
      request.fields['description'] = book.description!;
    if (book.pubDat != null) {
      request.fields['publication_date'] =
          book.pubDat!.toIso8601String().split('T').first;
    }

    request.fields['is_accept'] = (book.isAccept ?? true).toString();

    if (book.categories != null) {
      for (final c in book.categories!) {
        request.fields['categories[]'] = c;
      }
    }

    if (imageFile != null && await imageFile.exists()) {
      final stream = http.ByteStream(imageFile.openRead());
      final length = await imageFile.length();
      final multipartFile = http.MultipartFile('image', stream, length,
          filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    final response = await request.send();
    print(' rrrrrrrrrrrrrr  ${response.statusCode}');
    final respStr = await response.stream.bytesToString();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    } else {
      throw Exception('Failed to add book: ${response.statusCode} - $respStr');
    }
  }

  Future<ChapterModel> addChapter({
    required int bookId,
    String? title,
    String? content,
    File? audioFile,
  }) async {
    final uri = ApiVariables().addChapter(bookId);
    final request = http.MultipartRequest('POST', uri);

    if (title != null) request.fields['title'] = title;
    if (content != null) request.fields['content_text'] = content;

    if (audioFile != null && await audioFile.exists()) {
      final stream = http.ByteStream(audioFile.openRead());
      final length = await audioFile.length();
      final multipartFile = http.MultipartFile(
        'audio',
        stream,
        length,
        filename: audioFile.path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final map = jsonDecode(respStr) as Map<String, dynamic>;
      return ChapterModel.fromJson(map);
    } else {
      throw ServerException(respStr);
    }
  }
}
