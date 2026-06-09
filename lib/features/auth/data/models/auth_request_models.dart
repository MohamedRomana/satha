import 'package:json_annotation/json_annotation.dart';

part 'auth_request_models.g.dart';

/// طلب تسجيل الدخول (لكل الأدوار) — [role] = customer / driver / admin.
@JsonSerializable(createFactory: false)
class LoginRequestModel {
  @JsonKey(name: 'phone_or_email')
  final String phoneOrEmail;
  final String password;
  final String role;
  final String? lang;

  LoginRequestModel({
    required this.phoneOrEmail,
    required this.password,
    required this.role,
    this.lang,
  });

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}

/// طلب تسجيل عميل جديد.
@JsonSerializable(createFactory: false)
class RegisterCustomerRequestModel {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String? image;

  RegisterCustomerRequestModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.image,
  });

  Map<String, dynamic> toJson() => _$RegisterCustomerRequestModelToJson(this);
}

/// بيانات السائق الشخصية (الخطوة 1).
@JsonSerializable(createFactory: false)
class DriverPersonalInfoModel {
  final String name;
  final String phone;
  final String email;
  final String password;
  @JsonKey(name: 'national_id')
  final String nationalId;
  final String city;
  final String? image;

  DriverPersonalInfoModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.nationalId,
    required this.city,
    this.image,
  });

  Map<String, dynamic> toJson() => _$DriverPersonalInfoModelToJson(this);
}

/// بيانات السطحة (الخطوة 2).
@JsonSerializable(createFactory: false)
class TowTruckModel {
  final String name;
  final String type; // normal / hydraulic
  @JsonKey(name: 'plate_number')
  final String plateNumber;
  @JsonKey(name: 'vehicle_model')
  final String vehicleModel;
  @JsonKey(name: 'vehicle_color')
  final String vehicleColor;
  @JsonKey(name: 'max_weight')
  final String? maxWeight;
  final String? image;

  TowTruckModel({
    required this.name,
    required this.type,
    required this.plateNumber,
    required this.vehicleModel,
    required this.vehicleColor,
    this.maxWeight,
    this.image,
  });

  Map<String, dynamic> toJson() => _$TowTruckModelToJson(this);
}

/// مستندات السائق (الخطوة 3).
@JsonSerializable(createFactory: false)
class DriverDocumentsModel {
  @JsonKey(name: 'national_id_front')
  final String? nationalIdFront;
  @JsonKey(name: 'national_id_back')
  final String? nationalIdBack;
  @JsonKey(name: 'driving_license')
  final String? drivingLicense;
  @JsonKey(name: 'vehicle_license')
  final String? vehicleLicense;
  @JsonKey(name: 'additional_permit')
  final String? additionalPermit;

  DriverDocumentsModel({
    this.nationalIdFront,
    this.nationalIdBack,
    this.drivingLicense,
    this.vehicleLicense,
    this.additionalPermit,
  });

  Map<String, dynamic> toJson() => _$DriverDocumentsModelToJson(this);
}

/// طلب تسجيل سائق كامل (الخطوة 4 — تجميع).
@JsonSerializable(createFactory: false)
class RegisterDriverRequestModel {
  @JsonKey(name: 'personal_info')
  final DriverPersonalInfoModel personalInfo;
  @JsonKey(name: 'tow_truck')
  final TowTruckModel towTruck;
  final DriverDocumentsModel documents;

  RegisterDriverRequestModel({
    required this.personalInfo,
    required this.towTruck,
    required this.documents,
  });

  Map<String, dynamic> toJson() => _$RegisterDriverRequestModelToJson(this);
}

/// طلب التحقق برمز OTP.
@JsonSerializable(createFactory: false)
class OtpRequestModel {
  final String identifier;
  final String code;

  OtpRequestModel({required this.identifier, required this.code});

  Map<String, dynamic> toJson() => _$OtpRequestModelToJson(this);
}

/// طلب نسيان كلمة المرور.
@JsonSerializable(createFactory: false)
class ForgotPasswordRequestModel {
  final String identifier;

  ForgotPasswordRequestModel({required this.identifier});

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestModelToJson(this);
}

/// طلب إعادة تعيين كلمة المرور.
@JsonSerializable(createFactory: false)
class ResetPasswordRequestModel {
  final String identifier;
  final String code;
  @JsonKey(name: 'new_password')
  final String newPassword;

  ResetPasswordRequestModel({
    required this.identifier,
    required this.code,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordRequestModelToJson(this);
}
