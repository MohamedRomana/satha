import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/message_model.dart';
import 'location_preview_sheet.dart';

/// فقاعة رسالة موقع (معاينة خريطة صغيرة + فتح بوتوم شيت بالخريطة الكاملة).
class LocationMessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool me;
  const LocationMessageBubble({
    super.key,
    required this.message,
    required this.me,
  });

  @override
  Widget build(BuildContext context) {
    final pos = LatLng(message.lat ?? 0, message.lng ?? 0);
    return GestureDetector(
      onTap: () => LocationPreviewSheet.show(
        context,
        lat: pos.latitude,
        lng: pos.longitude,
        address: message.address,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: SizedBox(
              width: 220.w,
              height: 120.h,
              child: Stack(
                children: [
                  IgnorePointer(
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: pos, zoom: 15),
                      markers: {
                        Marker(markerId: const MarkerId('loc'), position: pos),
                      },
                      liteModeEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      mapToolbarEnabled: false,
                    ),
                  ),
                  Positioned(
                    right: 8.w,
                    bottom: 8.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.open_in_full_rounded,
                              color: Colors.white, size: 12.w),
                          SizedBox(width: 4.w),
                          Text(
                            LocaleKeys.openInMaps.tr(),
                            style: TextStyle(
                              fontSize: 9.sp,
                              color: Colors.white,
                              fontFamily: FontFamily.tajawalBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 16.w,
                color: me ? Colors.white : AppColors.orange,
              ),
              SizedBox(width: 4.w),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 190.w),
                child: Text(
                  message.address ?? LocaleKeys.sharedLocation.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: me ? Colors.white : AppColors.mainText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
