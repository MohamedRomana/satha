/// نوع الرسالة في المحادثة.
enum MessageType { text, image, location, voice, system }

/// رسالة داخل محادثة.
class MessageModel {
  final String id;
  final String chatId;
  final MessageType type;
  final bool fromMe;
  final DateTime timestamp;
  final String? text;
  final String? imagePath;
  final double? lat;
  final double? lng;
  final String? address;
  final String? voicePath;
  final int? voiceMs; // مدّة التسجيل بالمللي ثانية

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.type,
    required this.fromMe,
    required this.timestamp,
    this.text,
    this.imagePath,
    this.lat,
    this.lng,
    this.address,
    this.voicePath,
    this.voiceMs,
  });
}
