import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'auth_response_model.g.dart';

/// استجابة المصادقة الموحّدة (login / register / verify).
@JsonSerializable()
class AuthResponseModel {
  final int? status;
  final String? message;
  final String? token;
  final UserModel? user;

  AuthResponseModel({this.status, this.message, this.token, this.user});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}
