import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../services/shared_preferences_service.dart';
import 'handling_exception_request.dart';

typedef FromJson<T> = T Function(String body);

class PutApi<T> with HandlingExceptionRequest {
  final Uri uri;
  final Map body;
  final FromJson fromJson;
  final bool isLogin;
  final Duration timeout;

  const PutApi({
    required this.uri,
    required this.body,
    required this.fromJson,
    this.isLogin = false,
    this.timeout = const Duration(seconds: 20),
  });

  Future<T> callRequest() async {
    try {
      final token = SharedPreferencesService.getToken();
      final fcmToken = SharedPreferencesService.getFcmToken();

      log('the token in the request header is ${token ?? ''}',
          name: 'request manager ==> put function ');
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'lang': SharedPreferencesService.getLanguage(),
        if (SharedPreferencesService.getIdCurrency() != null)
          'currency': '${SharedPreferencesService.getIdCurrency()}',
        if (token != null) 'Authorization': 'Bearer $token',
        if (fcmToken != null) 'fcm-token': fcmToken
      };

      var request = http.Request('PUT', uri);
      request.body = jsonEncode(body);
      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse =
          await request.send().timeout(timeout);
      log(request.body, name: "request body");
      http.Response response = await http.Response.fromStream(streamedResponse);
      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return fromJson(response.body);
      } else {
        Exception exception = getException(response: response);
        throw exception;
      }
    } on HttpException {
      log(
        'http exception',
        name: 'RequestManager put function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri',
        name: 'RequestManager put function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception',
        name: 'RequestManager put function',
      );
      rethrow;
    } catch (e) {
      log(
        e.toString(),
        name: 'RequestManager put function',
      );
      rethrow;
    }
  }
}
