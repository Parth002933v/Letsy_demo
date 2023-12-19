import 'package:flutter/material.dart';
import 'package:letsy_demo/features/home/view/home_view.dart';
import 'package:letsy_demo/features/outfit_collection/view/outfit_collection_view.dart';

class NavBarList {
  static getScreenView() {
    return [
      HomeView(),
      OutfitCollectionView(),
      Center(child: const Text('outfit of the day')),
      Center(child: const Text('favorite')),
      Center(child: const Text('setting')),
    ];
  }
}
