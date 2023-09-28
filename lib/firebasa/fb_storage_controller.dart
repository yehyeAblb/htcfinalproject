import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FbStorageController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String?> uploadFile(File? file, {required String path}) async {
    if (file == null) return null;
    var data = await _storage
        .ref()
        .child('$path/${DateTime.now().toString()}')
        .putFile(file);
    String link = await data.ref.getDownloadURL();
    return link;
  }
}
