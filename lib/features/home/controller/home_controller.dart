import 'dart:io' as io;
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsy_demo/core/core.dart';
import 'package:path_provider/path_provider.dart';

final homeControllerProvider =
    StateNotifierProvider<_HomeControllerNotifier, bool>((ref) {
  return _HomeControllerNotifier(ref: ref);
});

final getSavedImageProvider = FutureProvider((ref) async {
  final homeController = ref.watch(homeControllerProvider.notifier);
  return homeController._getSavedImages();
});

class _HomeControllerNotifier extends StateNotifier<bool> {
  final Ref _ref;
  _HomeControllerNotifier({required Ref ref})
      : _ref = ref,
        super(false);

  void pickAndSaveImages() async {
    final List<io.File> images = await pickImage();
    SaveImage(images: images);
    _ref.refresh(getSavedImageProvider);
  }

  Future<List<io.File>?> _getSavedImages() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final directory = Directory(appDir.path);
      List<FileSystemEntity> files = directory.listSync();

      List<File> imageFiles = [];

      for (var file in files) {
        if (file is File &&
            (file.path.endsWith('.png') ||
                file.path.endsWith('.jpg') ||
                file.path.endsWith('.jpeg'))) {
          imageFiles.add(file);
        }
      }

      return imageFiles;
    } catch (e) {
      return null;
    }
  }
}
