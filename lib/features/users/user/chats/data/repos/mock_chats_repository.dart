import '../../../orders/data/models/order_model.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import 'chats_repository.dart';

/// مستودع محادثات وهمي في الذاكرة.
class MockChatsRepository implements ChatsRepository {
  MockChatsRepository() {
    _chats.addAll(_seedChats());
    for (final c in _chats) {
      _messages[c.id] = _seedMessages(c.id);
    }
  }

  final List<ChatModel> _chats = [];
  final Map<String, List<MessageModel>> _messages = {};

  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 350));

  @override
  Future<List<ChatModel>> getChats() async {
    await _delay();
    final list = [..._chats];
    list.sort((a, b) => b.lastTime.compareTo(a.lastTime));
    return list;
  }

  @override
  Future<List<MessageModel>> getMessages(String chatId) async {
    await _delay();
    return List.unmodifiable(_messages[chatId] ?? const []);
  }

  @override
  Future<MessageModel> sendMessage(MessageModel message) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _messages.putIfAbsent(message.chatId, () => []).add(message);
    final i = _chats.indexWhere((c) => c.id == message.chatId);
    if (i != -1) {
      _chats[i] = _chats[i].copyWith(
        lastMessage: message.text ?? '📎',
        lastTime: message.timestamp,
      );
    }
    return message;
  }

  @override
  Future<void> markRead(String chatId) async {
    final i = _chats.indexWhere((c) => c.id == chatId);
    if (i != -1) _chats[i] = _chats[i].copyWith(unreadCount: 0);
  }

  // ---- بيانات وهمية ----
  List<ChatModel> _seedChats() => [
    ChatModel(
      id: 'c1',
      orderId: 'o10245',
      orderNumber: 'ST-10245',
      driverName: 'خالد العتيبي',
      lastMessage: 'أنا في الطريق إليك الآن.',
      lastTime: DateTime.fromMillisecondsSinceEpoch(1718000000000),
      unreadCount: 2,
      online: true,
      orderStatus: OrderStatus.offersReceived,
    ),
    ChatModel(
      id: 'c2',
      orderId: 'o10231',
      orderNumber: 'ST-10231',
      driverName: 'فهد الدوسري',
      lastMessage: 'تم توصيل سيارتك بنجاح، شكرًا لك.',
      lastTime: DateTime.fromMillisecondsSinceEpoch(1717000000000),
      unreadCount: 0,
      online: false,
      orderStatus: OrderStatus.completed,
    ),
  ];

  List<MessageModel> _seedMessages(String chatId) {
    final base = DateTime.fromMillisecondsSinceEpoch(1717900000000);
    return [
      MessageModel(
        id: '$chatId-m1',
        chatId: chatId,
        type: MessageType.system,
        fromMe: false,
        timestamp: base,
        text: 'تم ربط محادثتك بالسائق.',
      ),
      MessageModel(
        id: '$chatId-m2',
        chatId: chatId,
        type: MessageType.text,
        fromMe: false,
        timestamp: base.add(const Duration(minutes: 1)),
        text: 'السلام عليكم، أنا في الطريق إليك.',
      ),
      MessageModel(
        id: '$chatId-m3',
        chatId: chatId,
        type: MessageType.text,
        fromMe: true,
        timestamp: base.add(const Duration(minutes: 2)),
        text: 'وعليكم السلام، بانتظارك.',
      ),
    ];
  }
}
