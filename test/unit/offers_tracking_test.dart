import 'package:flutter_test/flutter_test.dart';

import 'package:satha/features/users/user/orders/data/models/offer_model.dart';
import 'package:satha/features/users/user/orders/data/repos/mock_offers_repository.dart';
import 'package:satha/features/users/user/orders/data/repos/mock_orders_repository.dart';
import 'package:satha/features/users/user/orders/data/services/live_tracking_service.dart';
import 'package:satha/features/users/user/orders/logic/offers/offers_cubit.dart';
import 'package:satha/features/users/user/orders/logic/otp_confirm/otp_confirm_cubit.dart';
import 'package:satha/features/users/user/orders/logic/otp_confirm/otp_confirm_state.dart';
import 'package:satha/features/users/user/orders/logic/rating/rating_cubit.dart';
import 'package:satha/features/users/user/orders/logic/rating/rating_state.dart';

void main() {
  group('Offers — accept/reject', () {
    test('قبول عرض يرفض باقي العروض', () async {
      final orders = MockOrdersRepository();
      final offersRepo = MockOffersRepository(orders);
      final cubit = OffersCubit(offersRepo, orders, 'o10245');
      await cubit.load();

      final first = cubit.visibleOffers.first;
      await cubit.acceptOffer(first.id);

      final accepted =
          cubit.offers.firstWhere((o) => o.id == first.id);
      expect(accepted.status, OfferStatus.accepted);
      expect(
        cubit.offers.where((o) => o.status == OfferStatus.rejected).length,
        2,
      );
      await cubit.close();
    });

    test('العرض المرفوض يختفي من القائمة المعروضة', () async {
      final orders = MockOrdersRepository();
      final offersRepo = MockOffersRepository(orders);
      final cubit = OffersCubit(offersRepo, orders, 'o10245');
      await cubit.load();

      final before = cubit.visibleOffers.length;
      final id = cubit.visibleOffers.first.id;
      await cubit.rejectOffer(id);

      expect(cubit.visibleOffers.length, before - 1);
      expect(cubit.visibleOffers.any((o) => o.id == id), isFalse);
      await cubit.close();
    });

    test('قبول العرض يحدّث حالة الطلب وسعره', () async {
      final orders = MockOrdersRepository();
      final offersRepo = MockOffersRepository(orders);
      final accepted = await offersRepo
          .getOffers('o10245')
          .then((list) => offersRepo.acceptOffer(list.first.id));
      final order = await orders.getById('o10245');
      expect(order!.acceptedPrice, accepted.price);
      expect(order.driverName, accepted.driver.name);
    });
  });

  group('Live tracking', () {
    test('التتبّع يصدر مواقع للسائق', () async {
      final orders = MockOrdersRepository();
      final order = (await orders.getOrders())
          .firstWhere((o) => o.id == 'o10245');
      final service = MockLiveTrackingService();

      final updates = await service.track(order).take(3).toList();
      expect(updates.length, 3);
      expect(updates.first.distanceRemainingKm, greaterThanOrEqualTo(0));
    });

    test('buildPath يبني مسارًا غير فارغ', () async {
      final orders = MockOrdersRepository();
      final order = (await orders.getOrders())
          .firstWhere((o) => o.id == 'o10245');
      final path = MockLiveTrackingService().buildPath(order);
      expect(path.length, greaterThan(2));
    });
  });

  group('OTP confirmation', () {
    test('الرمز 123456 ينجح', () async {
      final cubit = OtpConfirmCubit();
      await cubit.verify('123456');
      expect(cubit.state, isA<OtpConfirmSuccess>());
      await cubit.close();
    });

    test('رمز خاطئ يفشل', () async {
      final cubit = OtpConfirmCubit();
      await cubit.verify('000000');
      expect(cubit.state, isA<OtpConfirmError>());
      await cubit.close();
    });
  });

  group('Rating', () {
    test('إرسال التقييم ينجح بعد اختيار النجوم', () async {
      final cubit = RatingCubit();
      cubit.setStars(5);
      await cubit.submit();
      expect(cubit.state, isA<RatingSuccess>());
      await cubit.close();
    });

    test('الإرسال بدون نجوم يفشل', () async {
      final cubit = RatingCubit();
      await cubit.submit();
      expect(cubit.state, isA<RatingError>());
      await cubit.close();
    });
  });
}
