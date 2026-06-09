import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// شريحة إعلانية في الـ slider (العناوين مفاتيح ترجمة).
class HomePromo {
  final String titleKey;
  final String descKey;
  final String icon;
  const HomePromo({
    required this.titleKey,
    required this.descKey,
    required this.icon,
  });
}

/// نوع خدمة السطحة المعروضة في الهوم.
enum CustomerServiceType { normal, hydraulic }

class CustomerServiceItem {
  final CustomerServiceType type;
  final String titleKey;
  final String descKey;
  final String icon;
  const CustomerServiceItem({
    required this.type,
    required this.titleKey,
    required this.descKey,
    required this.icon,
  });
}

/// حالة مبسّطة لمعاينة الطلب في الهوم.
enum OrderPreviewStatus {
  searchingDrivers,
  offersReceived,
  driverOnWay,
  driverArrived,
  completed,
  canceled,
}

/// معاينة طلب في الهوم (نشط أو سابق).
class HomeOrderPreview {
  final String orderNumber;
  final String serviceTitleKey;
  final String vehicleName;
  final OrderPreviewStatus status;
  final String dateText;
  final num? price;
  final int offersCount;

  const HomeOrderPreview({
    required this.orderNumber,
    required this.serviceTitleKey,
    required this.vehicleName,
    required this.status,
    required this.dateText,
    this.price,
    this.offersCount = 0,
  });
}

/// بيانات شاشة الهوم (mock).
class HomeData {
  final String customerName;
  final int unreadNotifications;
  final List<HomePromo> promos;
  final List<CustomerServiceItem> services;
  final HomeOrderPreview? activeOrder;
  final List<HomeOrderPreview> recentOrders;

  const HomeData({
    required this.customerName,
    required this.unreadNotifications,
    required this.promos,
    required this.services,
    required this.activeOrder,
    required this.recentOrders,
  });
}

/// مصدر بيانات الهوم الوهمي.
const kHomePromos = <HomePromo>[
  HomePromo(
    titleKey: LocaleKeys.promo1Title,
    descKey: LocaleKeys.promo1Desc,
    icon: AppIcons.quickRescue,
  ),
  HomePromo(
    titleKey: LocaleKeys.promo2Title,
    descKey: LocaleKeys.promo2Desc,
    icon: AppIcons.towTruckHydraulic,
  ),
  HomePromo(
    titleKey: LocaleKeys.promo3Title,
    descKey: LocaleKeys.promo3Desc,
    icon: AppIcons.orders,
  ),
  HomePromo(
    titleKey: LocaleKeys.promo4Title,
    descKey: LocaleKeys.promo4Desc,
    icon: AppIcons.support,
  ),
];

const kHomeServices = <CustomerServiceItem>[
  CustomerServiceItem(
    type: CustomerServiceType.normal,
    titleKey: LocaleKeys.normalTow,
    descKey: LocaleKeys.normalTowDesc,
    icon: AppIcons.towTruckNormal,
  ),
  CustomerServiceItem(
    type: CustomerServiceType.hydraulic,
    titleKey: LocaleKeys.hydraulicTow,
    descKey: LocaleKeys.hydraulicTowDesc,
    icon: AppIcons.towTruckHydraulic,
  ),
];
