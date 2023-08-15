import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';


class CustomPicker {
  static Future<Uint8List?> imageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      allowMultiple: false,
      type: FileType.image,
      withData: true,
      withReadStream: true,
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      final stream = file.readStream;
      List<int> byteList = [];

      await for (var chunk in stream!) {
        byteList.addAll(chunk);
      }

      Uint8List byteData = Uint8List.fromList(byteList);
      return byteData;
    } else {
      return null;
    }
  }
}
