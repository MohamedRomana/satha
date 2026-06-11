import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/apis/auth_api_service.dart';
import '../../features/auth/data/datasources/mock_auth_data_source.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/users/user/create_order/data/services/current_location_service.dart';
import '../../features/users/user/create_order/data/services/geocoding_service.dart';
import '../../features/users/user/create_order/data/services/location_permission_service.dart';
import '../../features/users/user/create_order/data/services/route_service.dart';
import '../../features/users/user/orders/data/services/live_tracking_service.dart';
import '../../features/users/user/orders/data/repos/mock_offers_repository.dart';
import '../../features/users/user/orders/data/repos/mock_orders_repository.dart';
import '../../features/users/user/orders/data/repos/offers_repository.dart';
import '../../features/users/user/orders/data/repos/orders_repository.dart';
import '../../features/users/user/vehicles/data/repos/mock_vehicles_repository.dart';
import '../../features/users/user/vehicles/data/repos/vehicles_repository.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  final Dio dio = DioFactory.getDio();

  // ---- المصادقة (Auth) ----
  getIt.registerLazySingleton<AuthApiService>(() => AuthApiService(dio));
  getIt.registerLazySingleton<MockAuthDataSource>(() => MockAuthDataSource());
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt(), getIt()));

  // ---- العميل: السيارات ----
  getIt.registerLazySingleton<VehiclesRepository>(
    () => MockVehiclesRepository(),
  );

  // ---- العميل: المواقع والخرائط ----
  getIt.registerLazySingleton<GeocodingService>(() => GeocodingService());
  getIt.registerLazySingleton<LocationPermissionService>(
    () => LocationPermissionService(),
  );
  getIt.registerLazySingleton<CurrentLocationService>(
    () => CurrentLocationService(getIt()),
  );
  getIt.registerLazySingleton<RouteService>(() => MockRouteService());

  // ---- العميل: الطلبات والعروض ----
  getIt.registerLazySingleton<OrdersRepository>(() => MockOrdersRepository());
  getIt.registerLazySingleton<OffersRepository>(
    () => MockOffersRepository(getIt()),
  );
  getIt.registerLazySingleton<LiveTrackingService>(
    () => MockLiveTrackingService(),
  );
}
