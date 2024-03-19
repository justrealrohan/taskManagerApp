class UserData {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo;

  UserData({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.photo,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email; // Correctly refer to the instance variable
    data['firstName'] = firstName; // Correctly refer to the instance variable
    data['lastName'] = lastName; // Correctly refer to the instance variable
    data['mobile'] = mobile; // Correctly refer to the instance variable
    data['photo'] = photo; // Correctly refer to the instance variable
    return data;
  }

  String get fullName{
    return "$firstName $lastName";
  }
}
