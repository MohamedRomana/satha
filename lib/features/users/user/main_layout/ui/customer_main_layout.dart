import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:satha/features/users/user/chats/ui/customer_chats_screen.dart';
import 'package:satha/features/users/user/home/ui/customer_home.dart';
import 'package:satha/features/users/user/main_layout/logic/main_layout_cubit.dart';
import 'package:satha/features/users/user/orders/ui/customer_orders_screen.dart';
import 'package:satha/features/users/user/profile/ui/customer_profile_screen.dart';
import 'package:satha/features/users/user/vehicles/ui/customer_vehicles_screen.dart';
import 'widgets/customer_bottom_nav.dart';

/// الهيكل الرئيسي للعميل — IndexedStack يحافظ على حالة كل تبويب.
class CustomerMainLayout extends StatelessWidget {
  const CustomerMainLayout({super.key});

  static const _tabs = [
    CustomerHomeScreen(),
    CustomerOrdersScreen(),
    CustomerVehiclesScreen(),
    CustomerChatsScreen(),
    CustomerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainLayoutCubit(),
      child: BlocBuilder<MainLayoutCubit, int>(
        builder: (context, index) {
          final cubit = context.read<MainLayoutCubit>();
          return PopScope(
            canPop: index == 0,
            onPopInvokedWithResult: (didPop, _) {
              if (!didPop) cubit.changeTab(0);
            },
            child: Scaffold(
              body: IndexedStack(index: index, children: _tabs),
              bottomNavigationBar: CustomerBottomNav(
                current: index,
                onTap: cubit.changeTab,
              ),
            ),
          );
        },
      ),
    );
  }
}
