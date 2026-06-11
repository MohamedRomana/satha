import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// بوتوم شيت يعرض الموقع المُرسَل على خريطة كاملة.
class LocationPreviewSheet {
  static Future<void> show(
    BuildContext context, {
    required double lat,
    required double lng,
    String? address,
  }) {
    final pos = LatLng(lat, lng);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: 0.7.sh,
        decoration: BoxDecoration(
          color: AppColors.lightBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 44.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Icon(Icons.location_on_rounded,
                      color: AppColors.orange, size: 22.w),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      address ?? LocaleKeys.sharedLocation.tr(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.mainText,
                        fontFamily: FontFamily.tajawalBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: pos, zoom: 15),
                    markers: {
                      Marker(markerId: const MarkerId('loc'), position: pos),
                    },
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton.icon(
                  onPressed: () => _openExternal(lat, lng),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  icon: const Icon(Icons.map_rounded, color: Colors.white),
                  label: Text(
                    LocaleKeys.openInMaps.tr(),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _openExternal(double lat, double lng) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }
}
