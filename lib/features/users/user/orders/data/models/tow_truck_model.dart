import '../../../create_order/data/models/order_flow_models.dart';

/// بيانات السطحة الخاصة بالسائق.
class TowTruckModel {
  final OrderServiceType type;
  final String name;
  final String? imagePath;
  final String? plateNumber;

  const TowTruckModel({
    required this.type,
    required this.name,
    this.imagePath,
    this.plateNumber,
  });
}
