/// أحداث socket المحادثة (جاهزة للربط بالباك إند لاحقًا).
class ChatSocketEvents {
  ChatSocketEvents._();

  static const String newChatMessage = 'newChatMessage';
  static const String messageDelivered = 'messageDelivered';
  static const String messageRead = 'messageRead';
  static const String typingStarted = 'typingStarted';
  static const String typingStopped = 'typingStopped';
}
