import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';

/// صورة السيارة (مع Hero) — تعرض الملف أو أيقونة بديلة.
class VehicleImage extends StatelessWidget {
  final String? imagePath;
  final String heroTag;
  final double size;
  final double radius;

  const VehicleImage({
    super.key,
    required this.imagePath,
    required this.heroTag,
    this.size = 64,
    this.radius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;
    return Hero(
      tag: heroTag,
      child: Container(
        width: size.w,
        height: size.w,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.softOrange,
          borderRadius: BorderRadius.circular(radius.r),
        ),
        child: hasImage
            ? Image.file(File(imagePath!), fit: BoxFit.cover)
            : Center(
                child: AppSvgIcon(
                  assetPath: AppIcons.car,
                  size: (size * 0.5).w,
                  color: AppColors.orange,
                ),
              ),
      ),
    );
  }
}
