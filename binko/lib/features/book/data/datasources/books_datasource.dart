import 'dart:convert';
import 'dart:io';

import 'package:binko/core/error/exceptions.dart';
import 'package:binko/core/unified_api/api_variables.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
import 'package:binko/features/book/data/models/comment_model.dart';
import 'package:binko/features/book/data/models/reply_model.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../../../../core/services/dependecies.dart';
import '../../../../core/unified_api/get_api.dart';
import '../../../../core/unified_api/post_api.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import 'package:path/path.dart' as p;

@injectable
class RemoteBookDatasource {
  Future<List<BooksModel>> getAllBooks() async {
    final url = ApiVariables().getAllBooks();
    final response = await http.get(url);
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return List<BooksModel>.from(jsonDecode(response.body).map((e) {
        return BooksModel.fromJson(e);
      }).toList());
    } else {
      throw Exception('Failed to fetch books: ${response.statusCode}');
    }
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

  Future<void> addLike(int bookId) async {
    final userId = getIt<AuthBloc>().state.user?.id;

    final uri = ApiVariables().addLike(bookId, userId ?? 0);
    print('addLike -> POST $uri');
    try {
      final response = await http.post(
        uri,
        // headers: {
        //   'Accept': 'application/json',
        // },
      );
      print('addLike status: ${response.statusCode}');
      print('addLike body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return;
      } else {
        throw ServerException(
            'Failed to add like: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('addLike exception: $e');
      rethrow;
    }
  }

  Future<void> addBook(BooksModel book, {File? imageFile}) async {
    final uri = ApiVariables().addBook(book.author?.id ?? 0);
    final request = http.MultipartRequest('POST', uri);

    if (book.name != null) request.fields['name'] = book.name!;
    if (book.description != null)
      request.fields['description'] = book.description!;
    if (book.content != null) request.fields['content'] = book.content!;
    if (book.pubDat != null) {
      request.fields['publication_date'] =
          book.pubDat!.toIso8601String().split('T').first;
    }
    if (book.language != null) request.fields['language'] = book.language!;
    request.fields['is_accept'] = (book.isAccept ?? true).toString();
    if (book.categories != null && book.categories!.isNotEmpty) {
      request.fields['categories'] = jsonEncode(book.categories);
    }
    if (imageFile != null && await imageFile.exists()) {
      final stream = http.ByteStream(imageFile.openRead());
      final length = await imageFile.length();
      final filename = p.basename(imageFile.path);
      final multipartFile =
          http.MultipartFile('image', stream, length, filename: filename);
      request.files.add(multipartFile);
    }

    final response = await request.send();
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

  Future<List<CommentModel>> getCommentsByBookId(int bookId) async {
    final getApi = GetApi(
      uri: ApiVariables().getBookComments(bookId),
      fromJson: (s) {
        final decoded = jsonDecode(s);
        return List<CommentModel>.from(
            (decoded as List).map((e) => CommentModel.fromJson(e)));
      },
    );
    return await getApi.callRequest();
  }

  Future<void> addComment({
    required int userId,
    required int bookId,
    required String comment,
  }) async {
    final postApi = PostApi(
      uri: ApiVariables().addComment(userId, bookId),
      body: {
        'comment': comment,
      },
      fromJson: (s) {
        return null;
      },
    );
    return await postApi.callRequest();
  }

  Future<List<ReplyModel>> getRepliesByCommentId(int commentId) async {
    final uri = ApiVariables().getCommentReplies(commentId); // تأكد اسم الدالة
    final response = await http.get(uri, headers: {
      'Accept': 'application/json',

    });

    print('getReplies -> status: ${response.statusCode}');
    print('getReplies -> body: ${response.body}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ServerException(response.body);
    }

    final decoded = jsonDecode(response.body);

    // احصل على القائمة بغض النظر عن شكل الـ JSON
    List rawList = [];
    if (decoded is List) {
      rawList = decoded;
    } else if (decoded is Map<String, dynamic>) {
      if (decoded.containsKey('results')) {
        rawList = decoded['results'] as List;
      } else if (decoded.containsKey('data')) {
        rawList = decoded['data'] as List;
      } else {
        // في بعض الـ APIs بيرجّع map يحتوي على قائمة فقط داخل قيمة غير متوقعة
        // لو ما بنعرف الشكل نطبع ونرمي خطأ أرجع فاضي
        print('getReplies -> unexpected map keys: ${decoded.keys.toList()}');
        return [];
      }
    } else {
      print('getReplies -> unexpected decoded type: ${decoded.runtimeType}');
      return [];
    }

    print('getReplies -> server list length: ${rawList.length}');
    if (rawList.isNotEmpty) {
      final first = rawList.first;
      if (first is Map) print('getReplies -> first item keys: ${first.keys.toList()}');
    }

    // نحول كل عنصر بشكل آمن (نصلح أنواع الحقول إن لزم)
    final List<ReplyModel> replies = rawList.map<ReplyModel>((e) {
      final Map<String, dynamic> item = Map<String, dynamic>.from(e as Map);

      // 1) نضيف comment id صراحة حتى لو السيرفر ما رجعه
      item['comment'] = commentId;

      // 2) map server keys to our model keys (نحط النسخ اللي النموذج قد يتوقعها)
      // إذا السيرفر يرجع 'user' (مثال: 1) نضمن وجود 'user' و 'user_id'
      if (item.containsKey('user')) {
        item['user'] = item['user'];
        item['user_id'] = item['user']; // لبعض النماذج قد تتوقع user_id
      }
      // اسم المستخدم
      if (item.containsKey('name')) {
        item['user_name'] = item['name'];
        item['name'] = item['name'];
      }
      // صورة المستخدم
      if (item.containsKey('image')) {
        item['user_image'] = item['image'];
        item['image'] = item['image'];
      }

      // 3) نصلح parent لو جاي كسلسلة
      if (item.containsKey('parent') && item['parent'] is String) {
        final parsed = int.tryParse(item['parent']);
        if (parsed != null) item['parent'] = parsed;
      }

      // 4) الآن نستدعي fromJson (الـ model يجب يحاول قراءة الحقول المتوفرة)
      return ReplyModel.fromJson(item);
    }).toList();

    print('getReplies -> parsed replies count: ${replies.length}');
    return replies;
  }


  Future<void> addReply({
    required int userId,
    required int commentId,
    required String content,
    int? parentId,
  }) async {
    final postApi = PostApi(
      uri: ApiVariables().addReplyToComment(commentId, userId),
      body: {
        'content': content,
        if (parentId != null) 'parent': parentId.toString(),
      },
      fromJson: (s) => null,
    );
    return await postApi.callRequest();
  }

}
