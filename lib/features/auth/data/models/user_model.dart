import 'package:json_annotation/json_annotation.dart';
import 'app_user.dart';
import 'user_role.dart';

part 'user_model.g.dart';

/// نموذج المستخدم القادم من الـ API (كل الحقول nullable حسب الـ conventions).
@JsonSerializable()
class UserModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? role;
  @JsonKey(name: 'approval_status')
  final String? approvalStatus;
  final String? image;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.role,
    this.approvalStatus,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  AppUser toEntity() => AppUser(
    id: id?.toString() ?? '',
    name: name ?? '',
    phone: phone ?? '',
    email: email ?? '',
    role: UserRoleX.fromKey(role),
    approvalStatus: role == 'driver'
        ? DriverApprovalStatusX.fromKey(approvalStatus)
        : null,
    image: image,
  );
}
