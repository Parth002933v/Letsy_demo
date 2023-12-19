import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letsy_demo/common/app_button.dart';
import 'package:letsy_demo/common/app_image.dart';
import 'package:letsy_demo/constants/constants.dart';
import 'package:letsy_demo/features/edit/view/edit_view.dart';
import 'package:letsy_demo/features/home/components/components.dart';
import 'package:letsy_demo/features/home/controller/home_controller.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _getSavedImageP = ref.watch(getSavedImageProvider).value;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return await ref.refresh(getSavedImageProvider);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            key: const PageStorageKey('page'),
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                homeAppBar(),
                SizedBox(height: 60.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Editor',
                      style: GoogleFonts.robotoSerif(
                        fontSize: 30,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: SvgIcon(icon: AssetsConstants.ic_more_horizontal),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                GridView.builder(
                  // cacheExtent: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: 1 + (_getSavedImageP?.length ?? 0),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SquareButton(
                        key: UniqueKey(),
                        onTap: () async {
                          ref
                              .read(homeControllerProvider.notifier)
                              .pickAndSaveImages();
                        },
                      );
                    } else {
                      final e = _getSavedImageP![index - 1];
                      return SquareButton(
                        key: UniqueKey(),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditView(image: e),
                            ),
                          );
                        },
                        image: e,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
