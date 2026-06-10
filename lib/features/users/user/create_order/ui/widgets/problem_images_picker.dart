import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';

/// شبكة رفع صور المشكلة (حتى 4) مع معاينة وإزالة.
class ProblemImagesPicker extends StatelessWidget {
  final List<File> images;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  static const int maxImages = 4;

  const ProblemImagesPicker({
    super.key,
    required this.images,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: [
        for (var i = 0; i < images.length; i++)
          _Preview(file: images[i], onRemove: () => onRemove(i)),
        if (images.length < maxImages) _AddTile(onTap: onAdd),
      ],
    );
  }
}

class _Preview extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;
  const _Preview({required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74.w,
      height: 74.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 74.w,
            height: 74.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Image.file(file, fit: BoxFit.cover),
          ),
          PositionedDirectional(
            top: -6,
            end: -6,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 22.w,
                height: 22.w,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Icon(Icons.close_rounded, size: 13.w, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  final VoidCallback onTap;
  const _AddTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 74.w,
        height: 74.w,
        decoration: BoxDecoration(
          color: AppColors.softOrange.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: AppColors.orange.withValues(alpha: 0.5),
          ),
        ),
        child: Center(
          child: AppSvgIcon(
            assetPath: AppIcons.camera,
            size: 26.w,
            color: AppColors.orange,
          ),
        ),
      ),
    );
  }
}
