import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<List<File>> pickImage() async {
  List<File> images = [];
  final imagePicker = ImagePicker();

  final pickedImages = await imagePicker.pickMultiImage(imageQuality: 50);

  if (pickedImages.isNotEmpty) {
    for (final image in pickedImages) {
      images.add(File(image.path));
    }
  }
  return images;
}

void SaveImage({required List<File> images}) async {
  try {
    final appDir = await getApplicationDocumentsDirectory();

    for (File image in images) {
      final fileName = getFilePathToName(path: image.path);

      final savedImage = await image.copy('${appDir.path}/$fileName');
      print('Image saved to: ${savedImage.path}');
    }
  } catch (e) {
    print(e.toString());
  }
}

String getFilePathToName({required String path}) {
  print(path);

  final spit = path.split('/').last;
  return spit;
}
