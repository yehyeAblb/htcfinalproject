import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

mixin ConverterHelpers{
  Future<String?> converterFileToString(File? file)async{
    if(file == null) return null;
    Uint8List uint8list = await file.readAsBytes();
    return base64Encode(uint8list);
  }
}