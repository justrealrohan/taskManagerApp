import 'package:real_world_projects/data/models/user_data.dart';

class LoginResponse {
  String? status;
  String? token;
  UserData? userData;

  LoginResponse(
      {required this.status, required this.token, required this.userData});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userData = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
  }
}
