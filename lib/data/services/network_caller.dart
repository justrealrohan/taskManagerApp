import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import '../models/response_object.dart';

class NetworkCaller {
  static Future<ResponseObject> getRequest(String url) async {
    try {
      log('URL: $url');
      final Response response = await get(Uri.parse(url));
      log('Response: ${response.statusCode}');
      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
          isSuccess: true,
          statusCode: 200,
          responseBody: decodedResponse,
        );
      } else {
        return ResponseObject(
          isSuccess: false,
          statusCode: response.statusCode,
          responseBody: '',
          errorMessage: 'Failed to fetch data',
        );
      }
    } catch (e) {
      return ResponseObject(
        isSuccess: false,
        statusCode: -1,
        responseBody: '',
        errorMessage: e.toString(),
      );
    }
  }

  static Future<ResponseObject> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      log('URL: $url');
      final Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      log('Response: ${response.statusCode}');
      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
          isSuccess: true,
          statusCode: 200,
          responseBody: decodedResponse,
        );
      } else if(response.statusCode == 401) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
          isSuccess: false,
          statusCode: response.statusCode,
          responseBody: decodedResponse,
          errorMessage: 'Invalid credentials',
        );
      }
      else {
        return ResponseObject(
          isSuccess: false,
          statusCode: response.statusCode,
          responseBody: '',
          errorMessage: 'Failed to fetch data',
        );
      }
    } catch (e) {
      return ResponseObject(
        isSuccess: false,
        statusCode: -1,
        responseBody: '',
        errorMessage: e.toString(),
      );
    }
  }
}
