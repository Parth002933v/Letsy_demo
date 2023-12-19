import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letsy_demo/common/common.dart';
import 'package:letsy_demo/constants/constants.dart';

class RoundendSmallButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final bool isLoading;
  final Color color;
  final Color textColor;
  final String? icon;
  const RoundendSmallButton({
    super.key,
    required this.onTap,
    this.text = 'enter the text',
    this.isLoading = false,
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 60.w,
      onPressed: isLoading == true ? null : onTap,
      splashColor: Colors.grey,
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
      color: color,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(30),
      ),
      child: isLoading == true
          ? SizedBox(
              height: 20.w,
              width: 20.w,
              child: const Center(child: CircularProgressIndicator()),
            )
          : Row(
              children: [
                if (icon != null)
                  Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: SvgIcon(
                      icon: icon!,
                      width: 20,
                      higth: 20,
                    ),
                  ),
                Text(
                  text,
                  style: GoogleFonts.lato(
                    height: 0,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                  // style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  //       height: 0,
                  //       color: textColor,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                ),
              ],
            ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color color;
  final Color textColor;
  final EdgeInsets padding;
  final File? image;
  const SquareButton({
    Key? key,
    required this.onTap,
    this.text = 'enter the text',
    this.color = AppColor.DarkLight,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.all(0),
    // required File image,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 190.w,
      // width: 190.w,
      child: MaterialButton(
        onPressed: onTap,
        splashColor: Colors.grey,
        padding: padding,
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
        child: image == null
            ? SvgIcon(icon: AssetsConstants.ic_plus_home)
            : ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: SizedBox(
                  height: 190.w,
                  width: 190.w,
                  child: Image.file(
                    image!,

                    isAntiAlias: false,
                    fit: BoxFit.cover,
                    // filterQuality: FilterQuality.low,
                    scale: 0.1,
                  ),
                ),
              ),
      ),
    );
  }
}
