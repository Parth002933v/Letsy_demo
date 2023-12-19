import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letsy_demo/common/common.dart';
import 'package:letsy_demo/constants/constants.dart';

Widget homeAppBar() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w),
    child: AppBar(
      actions: [
        RoundendSmallButton(
          text: 'Get Pro',
          color: AppColor.DarkLight,
          textColor: Colors.white,
          onTap: () {},
        )
      ],
    ),
  );
}
