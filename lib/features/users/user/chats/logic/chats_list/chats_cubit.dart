import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/chat_model.dart';
import '../../data/repos/chats_repository.dart';
import 'chats_state.dart';

/// كيوبت قائمة المحادثات.
class ChatsCubit extends Cubit<ChatsState> {
  final ChatsRepository _repo;
  ChatsCubit(this._repo) : super(const ChatsState.initial());

  List<ChatModel> chats = [];

  Future<void> getChats({bool silent = false}) async {
    if (!silent) emit(const ChatsState.loading());
    try {
      chats = await _repo.getChats();
      if (isClosed) return;
      emit(ChatsState.success(chats));
    } catch (e) {
      if (isClosed) return;
      emit(ChatsState.error(e.toString()));
    }
  }
}
