// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:image_picker/image_picker.dart';

import '../enum/typemessage.dart';

class MessageModel {
  String message;
  XFile? image;
  TypeMessage typeMessage;

  MessageModel({
    required this.message,
    required this.image,
    required this.typeMessage,
  });
}
