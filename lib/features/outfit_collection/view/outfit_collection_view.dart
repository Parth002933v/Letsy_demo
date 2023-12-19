import 'package:flutter/material.dart';
import 'package:letsy_demo/common/common.dart';
import 'package:letsy_demo/constants/constants.dart';

class OutfitCollectionView extends StatelessWidget {
  const OutfitCollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          RoundendSmallButton(
            text: 'Get Pro',
            color: AppColor.DarkLight.withOpacity(0.5),
            textColor: Colors.white,
            onTap: () {},
          )
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
