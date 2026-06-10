/// خيارات ثابتة لفورم السيارة (mock).
class VehicleOptions {
  VehicleOptions._();

  static const List<String> brands = [
    'Toyota',
    'Hyundai',
    'Ford',
    'Kia',
    'Nissan',
    'Honda',
    'Chevrolet',
    'Mercedes-Benz',
    'BMW',
    'Lexus',
    'GMC',
    'أخرى',
  ];

  static const List<String> colors = [
    'أبيض',
    'أسود',
    'رمادي',
    'فضي',
    'أحمر',
    'أزرق',
    'أخضر',
    'بني',
    'ذهبي',
    'أخرى',
  ];

  /// السنوات من 2026 تنازليًا حتى 2005.
  static List<int> get years =>
      List.generate(22, (i) => 2026 - i);
}
