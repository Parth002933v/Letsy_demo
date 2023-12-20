import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsy_demo/features/application/components/bottom_bar_widget.dart';
import 'package:letsy_demo/features/application/components/nav_bar_list.dart';
import 'package:letsy_demo/features/application/controller/application_controller.dart';

class Application extends ConsumerStatefulWidget {
  const Application({super.key});

  @override
  ConsumerState createState() => _ApplicationState();
}

class _ApplicationState extends ConsumerState<Application> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavBarP = ref.watch(bottomNavBarProvider);
    final bottomNavBarN = ref.read(bottomNavBarProvider.notifier);
    return Scaffold(
      body: PageView(
        key: PageStorageKey('application'),
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: (value) => bottomNavBarN.update((state) => value),
        children: NavBarList.getScreenView(),
      ),
      bottomNavigationBar: applicationBottomNavigationBar(
          index: bottomNavBarP, ref: ref, controller: _controller),
    );
  }
}
