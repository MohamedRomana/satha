import 'package:satha/generated/locale_keys.g.dart';

/// فئة السيارة.
enum VehicleCategory { sedan, suv, hatchback, pickup, sports, luxury, other }

extension VehicleCategoryX on VehicleCategory {
  String get labelKey {
    switch (this) {
      case VehicleCategory.sedan:
        return LocaleKeys.catSedan;
      case VehicleCategory.suv:
        return LocaleKeys.catSuv;
      case VehicleCategory.hatchback:
        return LocaleKeys.catHatchback;
      case VehicleCategory.pickup:
        return LocaleKeys.catPickup;
      case VehicleCategory.sports:
        return LocaleKeys.catSports;
      case VehicleCategory.luxury:
        return LocaleKeys.catLuxury;
      case VehicleCategory.other:
        return LocaleKeys.catOther;
    }
  }
}

/// نموذج السيارة (محلي/mock — يمكن لاحقًا ربطه بـ JsonSerializable).
class VehicleModel {
  final String id;
  final String? imagePath;
  final String name;
  final String brand;
  final String model;
  final int year;
  final String color;
  final String plateNumber;
  final String chassisNumber;
  final VehicleCategory category;
  final String? notes;
  final bool isDefault;

  const VehicleModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.plateNumber,
    required this.chassisNumber,
    required this.category,
    this.imagePath,
    this.notes,
    this.isDefault = false,
  });

  VehicleModel copyWith({
    String? id,
    String? imagePath,
    String? name,
    String? brand,
    String? model,
    int? year,
    String? color,
    String? plateNumber,
    String? chassisNumber,
    VehicleCategory? category,
    String? notes,
    bool? isDefault,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      color: color ?? this.color,
      plateNumber: plateNumber ?? this.plateNumber,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
