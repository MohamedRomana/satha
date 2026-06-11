import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/message_model.dart';
import '../../data/repos/chats_repository.dart';
import 'chat_details_state.dart';

/// كيوبت تفاصيل المحادثة — تحميل الرسائل وإرسالها (mock).
class ChatDetailsCubit extends Cubit<ChatDetailsState> {
  final ChatsRepository _repo;
  final String chatId;
  ChatDetailsCubit(this._repo, this.chatId)
    : super(const ChatDetailsState.loading());

  List<MessageModel> messages = [];
  int _tick = 0;
  int _seq = 0;

  Future<void> load() async {
    emit(const ChatDetailsState.loading());
    try {
      messages = [...await _repo.getMessages(chatId)];
      await _repo.markRead(chatId);
      if (isClosed) return;
      emit(ChatDetailsState.loaded(_tick++));
    } catch (e) {
      if (isClosed) return;
      emit(ChatDetailsState.error(e.toString()));
    }
  }

  Future<void> sendText(String text, {required DateTime now}) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    await _send(
      MessageModel(
        id: '$chatId-out-${_seq++}',
        chatId: chatId,
        type: MessageType.text,
        fromMe: true,
        timestamp: now,
        text: trimmed,
      ),
    );
  }

  Future<void> sendImage(String path, {required DateTime now}) async {
    await _send(
      MessageModel(
        id: '$chatId-out-${_seq++}',
        chatId: chatId,
        type: MessageType.image,
        fromMe: true,
        timestamp: now,
        imagePath: path,
      ),
    );
  }

  Future<void> sendLocation(
    double lat,
    double lng, {
    required DateTime now,
  }) async {
    await _send(
      MessageModel(
        id: '$chatId-out-${_seq++}',
        chatId: chatId,
        type: MessageType.location,
        fromMe: true,
        timestamp: now,
        lat: lat,
        lng: lng,
      ),
    );
  }

  Future<void> _send(MessageModel message) async {
    messages.add(message);
    emit(ChatDetailsState.loaded(_tick++));
    await _repo.sendMessage(message);
    if (isClosed) return;
    emit(ChatDetailsState.loaded(_tick++));
  }
}
