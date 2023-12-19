import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsy_demo/constants/constants.dart';
import 'package:letsy_demo/common/common.dart';

BottomNavigationBarItem buildBottomNavigationBarItem({
  required String unselectedIcon,
  // required String selectedIcon,
  required String label,
}) {
  return BottomNavigationBarItem(
    backgroundColor: Colors.transparent,
    icon: SvgIcon(icon: unselectedIcon, color: Colors.grey),
    activeIcon: SvgIcon(icon: unselectedIcon, color: Colors.white),
    label: label,
  );
}

BottomNavigationBar applicationBottomNavigationBar({
  required int index,
  required WidgetRef ref,
  required PageController controller,
}) {
  return BottomNavigationBar(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    onTap: (value) => controller.animateToPage(
      value,
      duration: const Duration(milliseconds: 450),
      curve: Curves.linear,
    ),
    items: [
      buildBottomNavigationBarItem(
        unselectedIcon: AssetsConstants.ic_home,
        label: 'Home',
      ),
      buildBottomNavigationBarItem(
        unselectedIcon: AssetsConstants.ic_feed,
        label: 'search',
      ),
      buildBottomNavigationBarItem(
        unselectedIcon: AssetsConstants.ic_ootd,
        label: 'people',
      ),
      buildBottomNavigationBarItem(
        unselectedIcon: AssetsConstants.ic_like,
        label: 'notification',
      ),
      buildBottomNavigationBarItem(
        unselectedIcon: AssetsConstants.ic_settings,
        label: 'mail',
      ),
    ],
  );
}
