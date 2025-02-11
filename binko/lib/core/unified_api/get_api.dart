import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../services/shared_preferences_service.dart';
import 'handling_exception_request.dart';

typedef FromJson<T> = T Function(String body);

class GetApi<T> with HandlingExceptionRequest {
  final Uri uri;
  final FromJson fromJson;
  final Map? body;
  final bool getFCMToken;

  GetApi({
    required this.uri,
    required this.fromJson,
    this.body = const {},
    this.getFCMToken = false,
  });

  Future<T> callRequest() async {
    try {
      final token = SharedPreferencesService.getToken();
      final fcmToken = SharedPreferencesService.getFcmToken();

      log('the token in the request header is ${token ?? ''}',
          name: 'request manager ==> get function ');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'lang': SharedPreferencesService.getLanguage(),
        if (SharedPreferencesService.getIdCurrency() != null)
          'currency': '${SharedPreferencesService.getIdCurrency()}',
        if (token != null) 'Authorization': 'Bearer $token',
        if (fcmToken != null) 'fcm-token': fcmToken
      };
      var request = http.Request('GET', uri);
      request.body = jsonEncode(body);
      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse =
          await request.send().timeout(const Duration(seconds: 20));
      if (streamedResponse.statusCode == 403) {
        throw const HttpException('Forbidden');
      }

      http.Response response = await http.Response.fromStream(streamedResponse);
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return fromJson(response.body);
      } else {
        Exception exception = getException(response: response);
        throw exception;
      }
    } on HttpException {
      log(
        'http exception',
        name: 'RequestManager get function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri',
        name: 'RequestManager get function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception',
        name: 'RequestManager get function',
      );
      rethrow;
    } catch (e) {
      log(
        e.toString(),
        name: 'RequestManager get function',
      );
      rethrow;
    }
  }
}
