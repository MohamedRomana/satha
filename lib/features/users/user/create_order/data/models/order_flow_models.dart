import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// نوع خدمة السطحة في تدفّق الطلب.
enum OrderServiceType { normal, hydraulic }

class ServiceTypeModel {
  final OrderServiceType type;
  final String titleKey;
  final String descKey;
  final String icon;
  const ServiceTypeModel({
    required this.type,
    required this.titleKey,
    required this.descKey,
    required this.icon,
  });
}

extension OrderServiceTypeX on OrderServiceType {
  String get titleKey => this == OrderServiceType.hydraulic
      ? LocaleKeys.hydraulicTow
      : LocaleKeys.normalTow;
  String get icon => this == OrderServiceType.hydraulic
      ? AppIcons.towTruckHydraulic
      : AppIcons.towTruckNormal;
}

/// نوع المشكلة.
enum OrderProblemType {
  breakdown,
  accident,
  notWorking,
  tire,
  battery,
  fuel,
  transport,
  other,
}

class ProblemTypeModel {
  final OrderProblemType type;
  final String titleKey;
  final String icon;
  const ProblemTypeModel({
    required this.type,
    required this.titleKey,
    required this.icon,
  });
}

extension OrderProblemTypeX on OrderProblemType {
  ProblemTypeModel get model =>
      kOrderProblems.firstWhere((p) => p.type == this);
  String get titleKey => model.titleKey;
  String get icon => model.icon;
}

const kOrderServices = <ServiceTypeModel>[
  ServiceTypeModel(
    type: OrderServiceType.normal,
    titleKey: LocaleKeys.normalTow,
    descKey: LocaleKeys.normalTowDesc,
    icon: AppIcons.towTruckNormal,
  ),
  ServiceTypeModel(
    type: OrderServiceType.hydraulic,
    titleKey: LocaleKeys.hydraulicTow,
    descKey: LocaleKeys.hydraulicTowDesc,
    icon: AppIcons.towTruckHydraulic,
  ),
];

const kOrderProblems = <ProblemTypeModel>[
  ProblemTypeModel(
    type: OrderProblemType.breakdown,
    titleKey: LocaleKeys.probBreakdown,
    icon: 'assets/icons/orders/breakdown.svg',
  ),
  ProblemTypeModel(
    type: OrderProblemType.accident,
    titleKey: LocaleKeys.probAccident,
    icon: 'assets/icons/orders/accident.svg',
  ),
  ProblemTypeModel(
    type: OrderProblemType.notWorking,
    titleKey: LocaleKeys.probNotWorking,
    icon: 'assets/icons/orders/car_not_working.svg',
  ),
  ProblemTypeModel(
    type: OrderProblemType.tire,
    titleKey: LocaleKeys.probTire,
    icon: 'assets/icons/orders/tire.svg',
  ),
  ProblemTypeModel(
    type: OrderProblemType.battery,
    titleKey: LocaleKeys.probBattery,
    icon: 'assets/icons/orders/battery.svg',
  ),
  ProblemTypeModel(
    type: OrderProblemType.fuel,
    titleKey: LocaleKeys.probFuel,
    icon: 'assets/icons/orders/fuel.svg',
  ),
  ProblemTypeModel(
    type: OrderProblemType.transport,
    titleKey: LocaleKeys.probTransport,
    icon: 'assets/icons/orders/transport.svg',
  ),
  ProblemTypeModel(
    type: OrderProblemType.other,
    titleKey: LocaleKeys.probOther,
    icon: 'assets/icons/orders/other.svg',
  ),
];
