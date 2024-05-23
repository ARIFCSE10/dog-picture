import 'dart:convert';

class BaseResponse {
  BaseResponse({
    this.status,
    this.message,
  });

  factory BaseResponse.fromRawJson(String str) =>
      BaseResponse.fromJson(json.decode(str));
  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        status: json['status'],
        message: json['message'],
      );

  String? status;
  dynamic message;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'message': message,
      };
}
