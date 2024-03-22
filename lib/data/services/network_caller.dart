import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:real_world_projects/app.dart';
import 'package:real_world_projects/presentation/controllers/auth_controller.dart';
import 'package:real_world_projects/presentation/screens/auth/sign_in_screen.dart';
import '../models/response_object.dart';

class NetworkCaller {
  static Future<ResponseObject> getRequest(String url) async {
    try {
      final Response response = await get(
        Uri.parse(url),
        headers: {'token': AuthController.accessToken ?? ''},
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
      } else if (response.statusCode == 401) {
        moveToSignIn();
        return ResponseObject(
          isSuccess: false,
          statusCode: response.statusCode,
          responseBody: '',
          errorMessage: 'Failed to fetch data',
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

  static Future<ResponseObject> postRequest(String url,
      Map<String, dynamic> body,
      {bool fromSignIn = false}) async {
    try {
      log('URL: $url');
      final Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken ?? ' '
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
      } else if (response.statusCode == 401) {
        if (fromSignIn) {
          final decodedResponse = jsonDecode(response.body);
          return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: decodedResponse,
            errorMessage: 'Invalid credentials',
          );
        } else {
          moveToSignIn();
          return ResponseObject(
              statusCode: response.statusCode,
              responseBody: response.body,
              isSuccess: false);
        }
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

  static void moveToSignIn() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
        TaskManager.navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ) as String,
            (route) => false);
  }

}
