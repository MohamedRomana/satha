import 'package:satha/core/constants/colors.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../../create_order/data/models/location_models.dart';
import '../../../create_order/data/models/order_flow_models.dart';
import '../../../vehicles/data/models/vehicle_model.dart';

/// حالة الطلب (المجموعة الكاملة).
enum OrderStatus {
  draft,
  searchingDrivers,
  offersReceived,
  offerAccepted,
  driverOnWay,
  driverArrived,
  pickupConfirmed,
  tripStarted,
  destinationReached,
  completed,
  canceledByCustomer,
  canceledByDriver,
  canceledByAdmin,
  expired,
  disputed,
}

extension OrderStatusX on OrderStatus {
  bool get isActive => const [
    OrderStatus.searchingDrivers,
    OrderStatus.offersReceived,
    OrderStatus.offerAccepted,
    OrderStatus.driverOnWay,
    OrderStatus.driverArrived,
    OrderStatus.pickupConfirmed,
    OrderStatus.tripStarted,
    OrderStatus.destinationReached,
  ].contains(this);

  bool get isCompleted => this == OrderStatus.completed;

  bool get isCanceled => const [
    OrderStatus.canceledByCustomer,
    OrderStatus.canceledByDriver,
    OrderStatus.canceledByAdmin,
    OrderStatus.expired,
  ].contains(this);

  String get labelKey {
    switch (this) {
      case OrderStatus.searchingDrivers:
        return LocaleKeys.statusSearchingDrivers;
      case OrderStatus.offersReceived:
        return LocaleKeys.statusOffersReceived;
      case OrderStatus.offerAccepted:
      case OrderStatus.driverOnWay:
        return LocaleKeys.statusDriverOnWay;
      case OrderStatus.driverArrived:
      case OrderStatus.pickupConfirmed:
        return LocaleKeys.statusDriverArrived;
      case OrderStatus.tripStarted:
      case OrderStatus.destinationReached:
        return LocaleKeys.statusTripStarted;
      case OrderStatus.completed:
        return LocaleKeys.statusCompleted;
      case OrderStatus.disputed:
        return LocaleKeys.statusDisputed;
      default:
        return LocaleKeys.statusCanceled;
    }
  }

  int get colorValue {
    if (isCompleted) return AppColors.success.toARGB32();
    if (isCanceled) return AppColors.error.toARGB32();
    switch (this) {
      case OrderStatus.searchingDrivers:
        return AppColors.warning.toARGB32();
      case OrderStatus.offersReceived:
        return AppColors.orange.toARGB32();
      default:
        return AppColors.navy.toARGB32();
    }
  }
}

/// نموذج الطلب (mock).
class OrderModel {
  final String id;
  final String orderNumber;
  final OrderStatus status;
  final OrderServiceType service;
  final VehicleModel vehicle;
  final OrderProblemType problem;
  final String? description;
  final List<String> problemImages;
  final LocationModel pickup;
  final LocationModel destination;
  final RouteInfoModel route;
  final String paymentMethod;
  final num? acceptedPrice;
  final DateTime createdAt;
  final int offersCount;
  final String? driverName;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.service,
    required this.vehicle,
    required this.problem,
    required this.pickup,
    required this.destination,
    required this.route,
    required this.createdAt,
    this.description,
    this.problemImages = const [],
    this.paymentMethod = 'cash',
    this.acceptedPrice,
    this.offersCount = 0,
    this.driverName,
  });

  OrderModel copyWith({
    OrderStatus? status,
    num? acceptedPrice,
    int? offersCount,
    String? driverName,
  }) {
    return OrderModel(
      id: id,
      orderNumber: orderNumber,
      status: status ?? this.status,
      service: service,
      vehicle: vehicle,
      problem: problem,
      description: description,
      problemImages: problemImages,
      pickup: pickup,
      destination: destination,
      route: route,
      paymentMethod: paymentMethod,
      acceptedPrice: acceptedPrice ?? this.acceptedPrice,
      createdAt: createdAt,
      offersCount: offersCount ?? this.offersCount,
      driverName: driverName ?? this.driverName,
    );
  }
}
