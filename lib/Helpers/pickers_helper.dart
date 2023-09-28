import 'dart:io';

import 'package:image_picker/image_picker.dart';

mixin PickersHelper {
  final ImagePicker _picker = ImagePicker();
  Future<File?> pickImage() async {
    XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return null;
    return File(file.path);
  }

  Future<List<File>> pickImages() async {
    var data = await _picker.pickMultiImage();
    return data.map((x) => File(x.path)).toList();
  }
}
