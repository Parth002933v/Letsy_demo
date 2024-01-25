import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

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

  // Future<List<Uint8List>?> _getSavedImages() async {
  //   try {
  //     final appDir = await getApplicationDocumentsDirectory();
  //     final directory = Directory(appDir.path);
  //     List<FileSystemEntity> files = directory.listSync();
  //
  //     List<Uint8List> imageFiles = [];
  //
  //     for (var file in files) {
  //       if (file is File &&
  //           file.existsSync() &&
  //           (file.path.endsWith('.png') ||
  //               file.path.endsWith('.jpg') ||
  //               file.path.endsWith('.jpeg'))) {
  //         imageFiles.add(await file.readAsBytes());
  //       }
  //     }
  //
  //     return imageFiles;
  //   } catch (e) {
  //     return null;
  //   }
  // }
  Future<List<Uint8List>?> _getSavedImages() async {
    ReceivePort receivePort = ReceivePort();
    Isolate isolate = await Isolate.spawn(
      decodeImagesInIsolate,
      receivePort.sendPort,
    );

    SendPort sendPort = await receivePort.first;
    SendPort? responsePort = ReceivePort().sendPort;

    final appDir = await getApplicationDocumentsDirectory();
    final directory = Directory(appDir.path);
    List<FileSystemEntity> files = directory.listSync();

    List<Uint8List> imageFiles = [];

    for (var file in files) {
      if (file is File &&
          file.existsSync() &&
          (file.path.endsWith('.png') ||
              file.path.endsWith('.jpg') ||
              file.path.endsWith('.jpeg'))) {
        responsePort!.send(file.path);
      }
    }

    responsePort!.send(null); // Signal end of image paths

    await for (var data in receivePort) {
      if (data is Uint8List) {
        imageFiles.add(data);
      } else {
        break; // End of communication
      }
    }

    receivePort.close();
    isolate.kill(priority: Isolate.immediate);

    return imageFiles.isNotEmpty ? imageFiles : null;
  }

  void decodeImagesInIsolate(SendPort sendPort) {
    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((message) async {
      if (message is String) {
        try {
          File imageFile = File(message);
          Uint8List imageData = await imageFile.readAsBytes();
          sendPort.send(imageData);
        } catch (e) {
          sendPort.send(null);
        }
      } else {
        receivePort.close();
      }
    });
  }
}
