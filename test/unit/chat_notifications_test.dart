import 'package:flutter_test/flutter_test.dart';

import 'package:satha/core/logic/action_state.dart';
import 'package:satha/features/users/user/chats/data/repos/mock_chats_repository.dart';
import 'package:satha/features/users/user/chats/logic/chat_details/chat_details_cubit.dart';
import 'package:satha/features/users/user/notifications/data/repos/mock_notifications_repository.dart';
import 'package:satha/features/users/user/notifications/logic/notifications_cubit.dart';
import 'package:satha/features/users/user/support/data/repos/mock_support_repository.dart';
import 'package:satha/features/users/user/support/logic/report_issue_cubit.dart';
import 'package:satha/features/users/user/support/data/models/support_models.dart';

void main() {
  final fixedNow = DateTime.fromMillisecondsSinceEpoch(1718000000000);

  group('Chats', () {
    test('المستودع يُهيّئ محادثتين', () async {
      final chats = await MockChatsRepository().getChats();
      expect(chats.length, 2);
    });

    test('إرسال رسالة نصّية يضيفها للقائمة', () async {
      final repo = MockChatsRepository();
      final cubit = ChatDetailsCubit(repo, 'c1');
      await cubit.load();
      final before = cubit.messages.length;
      await cubit.sendText('مرحبا', now: fixedNow);
      expect(cubit.messages.length, before + 1);
      expect(cubit.messages.last.fromMe, isTrue);
      expect(cubit.messages.last.text, 'مرحبا');
      await cubit.close();
    });

    test('الرسالة الفارغة لا تُرسَل', () async {
      final repo = MockChatsRepository();
      final cubit = ChatDetailsCubit(repo, 'c1');
      await cubit.load();
      final before = cubit.messages.length;
      await cubit.sendText('   ', now: fixedNow);
      expect(cubit.messages.length, before);
      await cubit.close();
    });
  });

  group('Notifications', () {
    test('تعليم الكل كمقروء يصفّر العدّاد', () async {
      final cubit = NotificationsCubit(MockNotificationsRepository());
      await cubit.load();
      expect(cubit.unreadCount, greaterThan(0));
      await cubit.markAllRead();
      expect(cubit.unreadCount, 0);
      await cubit.close();
    });

    test('قراءة إشعار واحد تنقص العدّاد', () async {
      final cubit = NotificationsCubit(MockNotificationsRepository());
      await cubit.load();
      final before = cubit.unreadCount;
      final unread = cubit.items.firstWhere((n) => !n.read);
      await cubit.markRead(unread.id);
      expect(cubit.unreadCount, before - 1);
      await cubit.close();
    });

    test('حذف إشعار يزيله من القائمة', () async {
      final cubit = NotificationsCubit(MockNotificationsRepository());
      await cubit.load();
      final before = cubit.items.length;
      final id = cubit.items.first.id;
      await cubit.delete(id);
      expect(cubit.items.length, before - 1);
      expect(cubit.items.any((n) => n.id == id), isFalse);
      await cubit.close();
    });
  });

  group('Report issue', () {
    test('الإرسال بدون فئة يفشل', () async {
      final cubit = ReportIssueCubit(MockSupportRepository());
      cubit.description = 'مشكلة ما';
      await cubit.submit();
      expect(cubit.state, isA<ActionError>());
      await cubit.close();
    });

    test('الإرسال بدون وصف يفشل', () async {
      final cubit = ReportIssueCubit(MockSupportRepository());
      cubit.selectCategory(ComplaintCategory.driver);
      await cubit.submit();
      expect(cubit.state, isA<ActionError>());
      await cubit.close();
    });

    test('الإرسال الصحيح ينجح', () async {
      final cubit = ReportIssueCubit(MockSupportRepository());
      cubit.selectCategory(ComplaintCategory.price);
      cubit.description = 'السعر مرتفع';
      await cubit.submit();
      expect(cubit.state, isA<ActionSuccess>());
      await cubit.close();
    });
  });

  group('Support', () {
    test('قائمة الأسئلة الشائعة بها ستة أسئلة', () {
      final faqs = MockSupportRepository().getFaqs();
      expect(faqs.length, 6);
    });
  });
}
