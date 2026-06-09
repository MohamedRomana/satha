// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$LoginRequestModelToJson(LoginRequestModel instance) =>
    <String, dynamic>{
      'phone_or_email': instance.phoneOrEmail,
      'password': instance.password,
      'role': instance.role,
      'lang': instance.lang,
    };

Map<String, dynamic> _$RegisterCustomerRequestModelToJson(
  RegisterCustomerRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'email': instance.email,
  'password': instance.password,
  'image': instance.image,
};

Map<String, dynamic> _$DriverPersonalInfoModelToJson(
  DriverPersonalInfoModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'email': instance.email,
  'password': instance.password,
  'national_id': instance.nationalId,
  'city': instance.city,
  'image': instance.image,
};

Map<String, dynamic> _$TowTruckModelToJson(TowTruckModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'plate_number': instance.plateNumber,
      'vehicle_model': instance.vehicleModel,
      'vehicle_color': instance.vehicleColor,
      'max_weight': instance.maxWeight,
      'image': instance.image,
    };

Map<String, dynamic> _$DriverDocumentsModelToJson(
  DriverDocumentsModel instance,
) => <String, dynamic>{
  'national_id_front': instance.nationalIdFront,
  'national_id_back': instance.nationalIdBack,
  'driving_license': instance.drivingLicense,
  'vehicle_license': instance.vehicleLicense,
  'additional_permit': instance.additionalPermit,
};

Map<String, dynamic> _$RegisterDriverRequestModelToJson(
  RegisterDriverRequestModel instance,
) => <String, dynamic>{
  'personal_info': instance.personalInfo,
  'tow_truck': instance.towTruck,
  'documents': instance.documents,
};

Map<String, dynamic> _$OtpRequestModelToJson(OtpRequestModel instance) =>
    <String, dynamic>{'identifier': instance.identifier, 'code': instance.code};

Map<String, dynamic> _$ForgotPasswordRequestModelToJson(
  ForgotPasswordRequestModel instance,
) => <String, dynamic>{'identifier': instance.identifier};

Map<String, dynamic> _$ResetPasswordRequestModelToJson(
  ResetPasswordRequestModel instance,
) => <String, dynamic>{
  'identifier': instance.identifier,
  'code': instance.code,
  'new_password': instance.newPassword,
};
