import '../models/chat_model.dart';
import '../models/message_model.dart';

/// واجهة مستودع المحادثات.
abstract class ChatsRepository {
  Future<List<ChatModel>> getChats();
  Future<List<MessageModel>> getMessages(String chatId);
  Future<MessageModel> sendMessage(MessageModel message);
  Future<void> markRead(String chatId);
}
