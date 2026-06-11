import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_state.freezed.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState.loading() = NotificationsLoading;
  const factory NotificationsState.loaded(int tick) = NotificationsLoaded;
  const factory NotificationsState.error(String message) = NotificationsError;
}
