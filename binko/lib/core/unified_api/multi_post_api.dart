import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../extensions/log_colors_extension.dart';
import '../services/shared_preferences_service.dart';
import 'handling_exception_request.dart';

typedef FromJson<T> = T Function(String body);

class MultiPostApi with HandlingExceptionRequest {
  final Uri uri;
  final FromJson fromJson;
  final Map<String, String> body;
  final Map<String, String> files;
  final Duration timeout;

  const MultiPostApi({
    required this.uri,
    required this.body,
    required this.fromJson,
    required this.files,
    this.timeout = const Duration(seconds: 20),
  });

  Future<dynamic> callRequest() async {
    try {
      final token = SharedPreferencesService.getToken();
      final fcmToken = SharedPreferencesService.getFcmToken();

      log(
          'the token in the request header is '.logWhite +
              (token?.logCyan ?? ''),
          name: 'request manager ==> post function ');

      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'lang': SharedPreferencesService.getLanguage(),
        if (SharedPreferencesService.getIdCurrency() != null)
          'currency': '${SharedPreferencesService.getIdCurrency()}',
        if (token != null) 'Authorization': 'Bearer $token',
        if (fcmToken != null) 'fcm-token': fcmToken
      };
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      for (var item in files.entries) {
        try {
          request.files.add(await http.MultipartFile.fromPath(
            item.key,
            item.value,
            filename: item.value.split('/').last,
          ));
        } catch (e) {
          request.fields.addAll({item.key: item.value});
        }
      }

      request.fields.addAll(body);
      // log(request.fields.toString());
      log(request.files
          .map((e) {
            return e.field + e.filename!;
          })
          .toList()
          .toString());
      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse =
          await request.send().timeout(timeout);
      http.Response response = await http.Response.fromStream(streamedResponse);
      log(response.body.logGreen);
      log(response.statusCode.toString().logGreen);
      if (response.statusCode == 200) {
        return fromJson(response.body);
      } else {
        Exception exception = getException(response: response);
        throw exception;
      }
    } on HttpException {
      log(
        'http exception'.logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri'.logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception'.logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    } catch (e) {
      log(
        e.toString().logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    }
  }
}
