import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letsy_demo/common/common.dart';
import 'package:letsy_demo/constants/constants.dart';
import 'package:video_player/video_player.dart';

class OutfitCollectionView extends StatefulWidget {
  const OutfitCollectionView({super.key});

  @override
  State<OutfitCollectionView> createState() => _OutfitCollectionViewState();
}

class _OutfitCollectionViewState extends State<OutfitCollectionView> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlaye;
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _controller = VideoPlayerController.asset(AssetsConstantsVideo.sample);
    _initializeVideoPlaye = _controller.initialize().then((value) {
      _controller.play();
      _controller.setVolume(0);
      _controller.setLooping(true);
    });
    _controller.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    FutureBuilder(
                      future: _initializeVideoPlaye,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return SizedBox(
                            height: 500,
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    Positioned(
                      bottom: 20.h,
                      right: 20.w,
                      left: 20.w,
                      // width: 200.w,
                      child: RoundedButton(
                        text: 'Try On',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 40, bottom: 20),
                  child: Text(
                    'New This Week',
                    style: TextStyle(
                      fontSize: 25,
                      height: 0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                PageView.custom(
                  childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) => GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 9 / 11,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) => SquareButton(
                        onTap: () {},
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 10.w,
            top: 40.h,
            child: RoundendSmallButton(
              text: 'Get Pro',
              color: AppColor.DarkLight.withOpacity(0.5),
              textColor: Colors.white,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
