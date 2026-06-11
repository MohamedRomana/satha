import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/chat_model.dart';

part 'chats_state.freezed.dart';

@freezed
class ChatsState with _$ChatsState {
  const factory ChatsState.initial() = _Initial;
  const factory ChatsState.loading() = ChatsLoading;
  const factory ChatsState.success(List<ChatModel> chats) = ChatsSuccess;
  const factory ChatsState.error(String message) = ChatsError;
}
