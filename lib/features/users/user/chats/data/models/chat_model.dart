import '../../../orders/data/models/order_model.dart';

/// محادثة بين العميل والسائق مرتبطة بطلب.
class ChatModel {
  final String id;
  final String orderId;
  final String orderNumber;
  final String driverName;
  final String? driverImage;
  final String lastMessage;
  final DateTime lastTime;
  final int unreadCount;
  final bool online;
  final OrderStatus orderStatus;

  const ChatModel({
    required this.id,
    required this.orderId,
    required this.orderNumber,
    required this.driverName,
    required this.lastMessage,
    required this.lastTime,
    required this.unreadCount,
    required this.online,
    required this.orderStatus,
    this.driverImage,
  });

  ChatModel copyWith({int? unreadCount, String? lastMessage, DateTime? lastTime}) =>
      ChatModel(
        id: id,
        orderId: orderId,
        orderNumber: orderNumber,
        driverName: driverName,
        driverImage: driverImage,
        lastMessage: lastMessage ?? this.lastMessage,
        lastTime: lastTime ?? this.lastTime,
        unreadCount: unreadCount ?? this.unreadCount,
        online: online,
        orderStatus: orderStatus,
      );
}
