import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../constants/colors.dart';
import '../helper/extentions.dart';
import '../routing/routes.dart';
import 'app_button.dart';
import 'app_text.dart';

class CustomSuccessDialog extends StatefulWidget {
  final bool isCart;
  final bool isStore;
  const CustomSuccessDialog({
    super.key,
    required this.isCart,
    required this.isStore,
  });

  @override
  State<CustomSuccessDialog> createState() => _CustomSuccessDialogState();
}

class _CustomSuccessDialogState extends State<CustomSuccessDialog>
    with TickerProviderStateMixin {
  late final GifController successController;

  @override
  void initState() {
    super.initState();
    successController = GifController(vsync: this);
  }

  @override
  void dispose() {
    successController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Gif(
            height: 91.w,
            width: 91.w,
            fit: BoxFit.cover,
            image: AssetImage(Assets.img.logo.path),
            controller: successController,
            duration: const Duration(seconds: 3),
            autostart: Autostart.no,
            onFetchCompleted: () {
              successController.forward();
              // successController.repeat();
            },
          ),

          AppText(
            top: 30.h,
            text: LocaleKeys.order_sent_successfully.tr(),
            size: 24.sp,
            family: FontFamily.tajawalBold,
            fontWeight: FontWeight.w700,
          ),
          AppButton(
            bottom: 16.h,
            top: 16.h,
            onPressed: () {
              widget.isCart == true
                  ? context.pushReplacementNamed(
                      widget.isStore ? Routes.store : Routes.authored,
                    )
                  : context.pushNamedAndRemoveUntil(
                      Routes.homeLayout,
                      arguments: 0,
                      predicate: (Route<dynamic> route) => false,
                    );
            },
            child: AppText(
              text: widget.isCart == true
                  ? LocaleKeys.continue_shopping.tr()
                  : LocaleKeys.continue_browsing.tr(),
              size: 16.sp,
              color: Colors.white,
              family: FontFamily.tajawalRegular,
              fontWeight: FontWeight.w400,
            ),
          ),
          AppButton(
            onPressed: () {
              context.pushNamedAndRemoveUntil(
                Routes.homeLayout,
                arguments: 1,
                predicate: (Route<dynamic> route) => false,
              );
            },
            color: AppColors.primary,
            child: AppText(
              text: LocaleKeys.orders.tr(),
              size: 16.sp,
              color: Colors.white,
              family: FontFamily.tajawalRegular,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
