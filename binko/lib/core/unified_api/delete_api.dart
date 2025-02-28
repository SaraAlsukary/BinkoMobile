import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../extensions/log_colors_extension.dart';
import '../services/shared_preferences_service.dart';
import 'handling_exception_request.dart';

typedef FromJson<T> = T Function(String body);

class DeleteApi<T> with HandlingExceptionRequest {
  final Uri uri;
  final FromJson fromJson;
  DeleteApi({
    required this.uri,
    required this.fromJson,
  });
  Future<T> callRequest() async {
    try {
      final token = SharedPreferencesService.getToken();
      final fcmToken = SharedPreferencesService.getFcmToken();

      log(
          'the token in the request header is '.logWhite +
              (token?.logCyan ?? ''),
          name: 'request manager ==> post function ');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'lang': SharedPreferencesService.getLanguage(),
        'Accept': 'application/json',
        if (SharedPreferencesService.getIdCurrency() != null)
          'currency': '${SharedPreferencesService.getIdCurrency()}',
        if (token != null) 'Authorization': 'Bearer $token',
        if (fcmToken != null) 'fcm_token': fcmToken
      };
      var request = http.Request('DELETE', uri);
      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse =
          await request.send().timeout(const Duration(seconds: 20));
      http.Response response = await http.Response.fromStream(streamedResponse);
      log(response.body.logGreen);
      if (response.statusCode == 200) {
        return fromJson(response.body);
      } else {
        Exception exception = getException(response: response);
        throw exception;
      }
    } on HttpException {
      log(
        'http exception'.logRed,
        name: 'RequestManager get function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri'.logRed,
        name: 'RequestManager get function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception'.logRed,
        name: 'RequestManager get function',
      );
      rethrow;
    } catch (e) {
      log(
        e.toString().logRed,
        name: 'RequestManager get function',
      );
      rethrow;
    }
  }
}
