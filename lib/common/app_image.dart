import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:letsy_demo/constants/assets_constants.dart';

SizedBox SvgIcon({
  String icon = AssetsConstants.ic_feed,
  double higth = 30,
  double width = 30,
  Color? color,
}) {
  return SizedBox(
    height: higth,
    width: width,
    child: SvgPicture.asset(
      icon,
      fit: BoxFit.contain,
      color: color,
    ),
  );
}
