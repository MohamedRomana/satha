/// أسماء أحداث الـ socket الخاصة بتتبّع الطلب (جاهزة للربط بالباك إند لاحقًا).
class OrderSocketEvents {
  OrderSocketEvents._();

  // إرسال (emit)
  static const String joinOrderRoom = 'joinOrderRoom';
  static const String leaveOrderRoom = 'leaveOrderRoom';

  // استقبال (on)
  static const String driverLocationUpdated = 'driverLocationUpdated';
  static const String orderStatusUpdated = 'orderStatusUpdated';
  static const String driverArrived = 'driverArrived';
  static const String tripStarted = 'tripStarted';
  static const String destinationReached = 'destinationReached';
  static const String orderCompleted = 'orderCompleted';
}
