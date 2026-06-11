import '../models/notification_model.dart';
import 'notifications_repository.dart';

/// مستودع إشعارات وهمي في الذاكرة.
class MockNotificationsRepository implements NotificationsRepository {
  MockNotificationsRepository() {
    _items.addAll(_seed());
  }

  final List<NotificationModel> _items = [];

  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 350));

  @override
  Future<List<NotificationModel>> getNotifications() async {
    await _delay();
    final list = [..._items];
    list.sort((a, b) => b.time.compareTo(a.time));
    return list;
  }

  @override
  Future<void> markRead(String id) async {
    final i = _items.indexWhere((n) => n.id == id);
    if (i != -1) _items[i] = _items[i].copyWith(read: true);
  }

  @override
  Future<void> markAllRead() async {
    for (var i = 0; i < _items.length; i++) {
      _items[i] = _items[i].copyWith(read: true);
    }
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((n) => n.id == id);
  }

  List<NotificationModel> _seed() {
    final now = DateTime.fromMillisecondsSinceEpoch(1718000000000);
    return [
      NotificationModel(
        id: 'n1',
        type: NotificationType.offer,
        title: 'عرض جديد',
        body: 'وصلك عرض جديد على طلبك.',
        time: now,
        read: false,
        orderId: 'o10245',
      ),
      NotificationModel(
        id: 'n2',
        type: NotificationType.orderStatus,
        title: 'تم قبول العرض',
        body: 'تم قبول العرض بنجاح.',
        time: now.subtract(const Duration(minutes: 30)),
        read: false,
        orderId: 'o10245',
      ),
      NotificationModel(
        id: 'n3',
        type: NotificationType.orderStatus,
        title: 'السائق في الطريق',
        body: 'السائق في الطريق إليك.',
        time: now.subtract(const Duration(hours: 1)),
        read: false,
        orderId: 'o10245',
      ),
      NotificationModel(
        id: 'n4',
        type: NotificationType.orderStatus,
        title: 'وصل السائق',
        body: 'وصل السائق إلى موقعك.',
        time: now.subtract(const Duration(hours: 2)),
        read: true,
        orderId: 'o10245',
      ),
      NotificationModel(
        id: 'n5',
        type: NotificationType.orderStatus,
        title: 'اكتملت الرحلة',
        body: 'تم اكتمال الرحلة بنجاح.',
        time: now.subtract(const Duration(days: 1)),
        read: true,
        orderId: 'o10231',
      ),
      NotificationModel(
        id: 'n6',
        type: NotificationType.chat,
        title: 'رسالة جديدة',
        body: 'لديك رسالة جديدة من السائق.',
        time: now.subtract(const Duration(days: 1, hours: 2)),
        read: true,
        orderId: 'o10231',
      ),
    ];
  }
}
