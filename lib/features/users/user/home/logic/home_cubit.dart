import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:satha/core/cache/cache_helper.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/home_models.dart';
import 'home_state.dart';

/// كيوبت شاشة الهوم — يجهّز بيانات وهمية (mock) للعرض.
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.loading());

  HomeData? data;

  Future<void> load() async {
    emit(const HomeState.loading());
    await Future.delayed(const Duration(milliseconds: 400));
    if (isClosed) return;
    final name = CacheHelper.getUserName();
    data = HomeData(
      customerName: name.isEmpty ? 'محمد' : name,
      unreadNotifications: 3,
      promos: kHomePromos,
      services: kHomeServices,
      activeOrder: const HomeOrderPreview(
        orderNumber: 'ST-10245',
        serviceTitleKey: LocaleKeys.normalTow,
        vehicleName: 'Toyota Camry',
        status: OrderPreviewStatus.offersReceived,
        dateText: 'اليوم 10:24 ص',
        offersCount: 3,
      ),
      recentOrders: const [
        HomeOrderPreview(
          orderNumber: 'ST-10231',
          serviceTitleKey: LocaleKeys.hydraulicTow,
          vehicleName: 'Hyundai Santa Fe',
          status: OrderPreviewStatus.completed,
          dateText: 'أمس 8:10 م',
          price: 180,
        ),
        HomeOrderPreview(
          orderNumber: 'ST-10210',
          serviceTitleKey: LocaleKeys.normalTow,
          vehicleName: 'Ford Ranger',
          status: OrderPreviewStatus.canceled,
          dateText: '12 يونيو',
        ),
      ],
    );
    emit(HomeState.loaded(data!));
  }
}
