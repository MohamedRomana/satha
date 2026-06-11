import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/image_source_sheet.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../create_order/data/services/current_location_service.dart';
import '../../create_order/data/services/location_permission_service.dart';
import '../data/models/chat_model.dart';
import '../logic/chat_details/chat_details_cubit.dart';
import '../logic/chat_details/chat_details_state.dart';
import 'widgets/chat_input_bar.dart';
import 'widgets/message_bubble.dart';

/// شاشة تفاصيل المحادثة مع السائق.
class CustomerChatDetailsScreen extends StatelessWidget {
  final ChatModel chat;
  const CustomerChatDetailsScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatDetailsCubit(getIt(), chat.id)..load(),
      child: _ChatDetailsView(chat: chat),
    );
  }
}

class _ChatDetailsView extends StatefulWidget {
  final ChatModel chat;
  const _ChatDetailsView({required this.chat});

  @override
  State<_ChatDetailsView> createState() => _ChatDetailsViewState();
}

class _ChatDetailsViewState extends State<_ChatDetailsView> {
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _attachImage(BuildContext context) async {
    final source = await ImageSourceSheet.show(context);
    if (source == null || !context.mounted) return;
    final picked = await ImagePicker().pickImage(source: source);
    if (picked == null || !context.mounted) return;
    context.read<ChatDetailsCubit>().sendImage(
      picked.path,
      now: DateTime.now(),
    );
  }

  bool _sendingLocation = false;

  Future<void> _sendLocation(BuildContext context) async {
    if (_sendingLocation) return;
    final cubit = context.read<ChatDetailsCubit>();
    setState(() => _sendingLocation = true);
    try {
      final status = await getIt<LocationPermissionService>().ensurePermission();
      if (status != LocationPermissionStatus.granted) {
        if (context.mounted) {
          showFlashMessage(
            message: LocaleKeys.permDeniedMsg.tr(),
            type: FlashMessageType.warning,
            context: context,
          );
        }
        return;
      }
      final loc = await getIt<CurrentLocationService>().getCurrent();
      if (cubit.isClosed) return;
      await cubit.sendLocation(
        loc.lat,
        loc.lng,
        now: DateTime.now(),
        address: loc.address,
      );
      if (context.mounted) {
        showFlashMessage(
          message: LocaleKeys.locationShared.tr(),
          type: FlashMessageType.success,
          context: context,
        );
      }
    } catch (_) {
      if (context.mounted) {
        showFlashMessage(
          message: LocaleKeys.something_went_wrong.tr(),
          type: FlashMessageType.error,
          context: context,
        );
      }
    } finally {
      if (mounted) setState(() => _sendingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatDetailsCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.softOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person_rounded,
                  color: AppColors.orange, size: 22.w),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.chat.driverName,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.mainText,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                  Text(
                    widget.chat.online
                        ? LocaleKeys.onlineNow.tr()
                        : '${LocaleKeys.orderNumberShort.tr()} ${widget.chat.orderNumber}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: widget.chat.online
                          ? AppColors.success
                          : AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_rounded, color: AppColors.success),
          ),
          IconButton(
            onPressed: () => context.pushNamed(Routes.reportIssue),
            icon: const Icon(Icons.flag_outlined, color: AppColors.warning),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatDetailsCubit, ChatDetailsState>(
              listener: (_, __) => _scrollToEnd(),
              builder: (context, state) {
                if (state is ChatDetailsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.orange),
                  );
                }
                final messages = cubit.messages;
                return ListView.builder(
                  controller: _scroll,
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                  itemCount: messages.length,
                  itemBuilder: (_, i) => MessageBubble(message: messages[i]),
                );
              },
            ),
          ),
          ChatInputBar(
            onSendText: (text) =>
                cubit.sendText(text, now: DateTime.now()),
            onAttachImage: () => _attachImage(context),
            onSendLocation: () => _sendLocation(context),
            onSendVoice: (path, ms) =>
                cubit.sendVoice(path, ms, now: DateTime.now()),
          ),
        ],
      ),
    );
  }
}
