import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../gen/fonts.gen.dart';

/// منتقي صورة شخصية دائري مع زر كاميرا.
class ProfileImagePicker extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;
  final String? label;
  final double size;

  const ProfileImagePicker({
    super.key,
    required this.image,
    required this.onTap,
    this.label,
    this.size = 96,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: size.w,
                height: size.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.softOrange,
                  border: Border.all(color: AppColors.orange, width: 1.5),
                  image: image != null
                      ? DecorationImage(
                          image: FileImage(image!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: image == null
                    ? Icon(
                        Icons.person_rounded,
                        size: (size * 0.45).w,
                        color: AppColors.orange,
                      )
                    : null,
              ),
              PositionedDirectional(
                bottom: 0,
                end: 0,
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: 15.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (label != null) ...[
          SizedBox(height: 8.h),
          Text(
            label!,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.secondaryText,
              fontFamily: FontFamily.tajawalRegular,
            ),
          ),
        ],
      ],
    );
  }
}
