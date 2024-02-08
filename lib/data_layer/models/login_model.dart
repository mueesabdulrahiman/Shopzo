import 'dart:developer';

class LoginResponseModel {
  bool? success;
  int? statusCode;
  String? code;
  String? message;
  Data? data;

  LoginResponseModel(
      {this.success, this.statusCode, this.code, this.message, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    log('statuscode:${json['statusCode']}');
    return LoginResponseModel(
      success: json['success'],
      statusCode: json['statusCode'],
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> res = {};
    res['success'] = success;
    res['statusCode'] = statusCode;
    res['code'] = code;
    res['message'] = message;
    if (data != null) {
      res['data'] = data!.toJson();
    }
    //res['data'] = data != null ? data!.toJson() : null;
    return res;
  }
}

class Data {
  String? token;
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? niceName;
  String? displayName;

  Data({
    this.token,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.niceName,
    this.displayName,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        token: json['token'],
        id: json['id'],
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        niceName: json['nicename'],
        displayName: json['displayName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['token'] = token;
    data['id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['nicename'] = niceName;
    data['displayName'] = displayName;
    return data;
  }
}
