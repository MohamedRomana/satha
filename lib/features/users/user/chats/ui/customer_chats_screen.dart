import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/empty_data_widget.dart';
import 'package:satha/gen/assets.gen.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/chat_model.dart';
import '../logic/chats_list/chats_cubit.dart';
import '../logic/chats_list/chats_state.dart';
import 'widgets/chat_list_card.dart';

/// شاشة قائمة محادثات العميل.
class CustomerChatsScreen extends StatelessWidget {
  const CustomerChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatsCubit(getIt())..getChats(),
      child: const _ChatsView(),
    );
  }
}

class _ChatsView extends StatelessWidget {
  const _ChatsView();

  Future<void> _open(BuildContext context, ChatModel chat) async {
    final cubit = context.read<ChatsCubit>();
    await context.pushNamed(Routes.chatDetails, arguments: {'chat': chat});
    if (context.mounted) cubit.getChats(silent: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          LocaleKeys.navChats.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: BlocBuilder<ChatsCubit, ChatsState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            ),
            error: (_) => EmptyDataWidget(
              message: LocaleKeys.no_results.tr(),
              lottieName: Assets.img.error,
            ),
            orElse: () {
              final chats = context.read<ChatsCubit>().chats;
              if (chats.isEmpty) {
                return EmptyDataWidget(
                  message: LocaleKeys.noConversations.tr(),
                );
              }
              return AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                  itemCount: chats.length,
                  itemBuilder: (context, i) => AnimationConfiguration.staggeredList(
                    position: i,
                    duration: const Duration(milliseconds: 400),
                    child: SlideAnimation(
                      verticalOffset: 40,
                      child: FadeInAnimation(
                        child: ChatListCard(
                          chat: chats[i],
                          onTap: () => _open(context, chats[i]),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
