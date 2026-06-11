import '../models/notification_model.dart';

/// واجهة مستودع الإشعارات.
abstract class NotificationsRepository {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markRead(String id);
  Future<void> markAllRead();
  Future<void> delete(String id);
}
