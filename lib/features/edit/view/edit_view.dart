import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letsy_demo/common/app_button.dart';
import 'package:letsy_demo/common/app_image.dart';
import 'package:letsy_demo/constants/assets_constants.dart';

class EditView extends StatefulWidget {
  final Uint8List image;
  const EditView({
    super.key,
    required this.image,
  });

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.memory(
                widget.image,
                cacheHeight: 300,
                cacheWidth: 200,
                fit: BoxFit.fill,
                scale: 0.1,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
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
                            fontSize: 18,
                            height: 3,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.memory(
                          widget.image,
                          key: UniqueKey(),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Spacer(),
                      // SizedBox(height: 20.h),
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
          ],
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
