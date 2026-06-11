import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/notification_model.dart';
import '../data/repos/notifications_repository.dart';
import 'notifications_state.dart';

/// كيوبت الإشعارات — تحميل + قراءة + حذف.
class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository _repo;
  NotificationsCubit(this._repo) : super(const NotificationsLoading());

  List<NotificationModel> items = [];
  int _tick = 0;

  int get unreadCount => items.where((n) => !n.read).length;

  Future<void> load() async {
    emit(const NotificationsState.loading());
    try {
      items = await _repo.getNotifications();
      if (isClosed) return;
      emit(NotificationsState.loaded(_tick++));
    } catch (e) {
      if (isClosed) return;
      emit(NotificationsState.error(e.toString()));
    }
  }

  Future<void> markRead(String id) async {
    await _repo.markRead(id);
    items = await _repo.getNotifications();
    if (isClosed) return;
    emit(NotificationsState.loaded(_tick++));
  }

  Future<void> markAllRead() async {
    await _repo.markAllRead();
    items = await _repo.getNotifications();
    if (isClosed) return;
    emit(NotificationsState.loaded(_tick++));
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    items = await _repo.getNotifications();
    if (isClosed) return;
    emit(NotificationsState.loaded(_tick++));
  }
}
