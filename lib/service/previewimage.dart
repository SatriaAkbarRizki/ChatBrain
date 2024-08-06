import 'package:flutter/material.dart';

class PreviewImage with ChangeNotifier {
  bool showing = false;

  void setPreview(bool value) {
    showing = value;
    notifyListeners();
  }
}
