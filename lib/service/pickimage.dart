import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageUser with ChangeNotifier {
  XFile? image;
  File? imageFiles;
  Future<XFile> getImage() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then(
          (value) => image = value,
        );

    notifyListeners();
    return image!;
  }

  Future<XFile?> getFromCamera() async {
    await ImagePicker().pickImage(source: ImageSource.camera).then(
          (value) => image = value,
        );

    notifyListeners();
    return image;
  }

  void removeImage(){
    image = null;
    notifyListeners();
  }
}
