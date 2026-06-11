import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_details_state.freezed.dart';

@freezed
class ChatDetailsState with _$ChatDetailsState {
  const factory ChatDetailsState.loading() = ChatDetailsLoading;
  const factory ChatDetailsState.loaded(int tick) = ChatDetailsLoaded;
  const factory ChatDetailsState.error(String message) = ChatDetailsError;
}
