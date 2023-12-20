import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letsy_demo/common/app_button.dart';
import 'package:letsy_demo/common/app_image.dart';
import 'package:letsy_demo/constants/app_color_constant.dart';
import 'package:letsy_demo/constants/assets_constants.dart';

class EditView extends StatelessWidget {
  final Uint8List image;
  const EditView({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          scale: 0.1,
          image: MemoryImage(image, scale: 0.1),
          // image: FileImage(image, scale: 0.1),
          fit: BoxFit.fill,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ).copyWith(bottom: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Select Area to Modify',
                      style: TextStyle(
                          fontSize: 18, height: 3, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Image.memory(
                          image,
                          key: UniqueKey(),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        editButtonContanor(
                          icons: AssetsConstants.ic_close,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        RoundendSmallButton(
                          icon: AssetsConstants.ic_pencil,
                          onTap: () {},
                          text: 'Refine',
                          color: Colors.black.withOpacity(0.2),
                        ),
                        editButtonContanor(
                          icons: AssetsConstants.ic_check,
                          onTap: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget editButtonContanor(
      {required String icons, required void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.w,
        width: 45.w,
        padding: EdgeInsets.symmetric(
          vertical: 7.w,
          horizontal: 7.w,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.2),
        ),
        child: SvgIcon(icon: icons),
      ),
    );
  }
}
