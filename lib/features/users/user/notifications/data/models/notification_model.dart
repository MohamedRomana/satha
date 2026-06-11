/// نوع الإشعار.
enum NotificationType { offer, orderStatus, chat, system, promotion }

/// إشعار للعميل.
class NotificationModel {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime time;
  final bool read;
  final String? orderId;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    required this.read,
    this.orderId,
  });

  NotificationModel copyWith({bool? read}) => NotificationModel(
    id: id,
    type: type,
    title: title,
    body: body,
    time: time,
    read: read ?? this.read,
    orderId: orderId,
  );
}
