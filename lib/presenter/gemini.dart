import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:speakai/enum/typemessage.dart';
import 'package:speakai/model/message.dart';

class GeminiAi with ChangeNotifier {
  bool isLoading = false;
  int numberElement = 0;
  final apiKey = 'YOU API KEY';
  final List<MessageModel> _results = [];

  List<MessageModel> get results => _results;

  void addMessageUser(String message, XFile? image) {
    _results.add(MessageModel(
        message: message, image: image, typeMessage: TypeMessage.user));
    numberElement++;
    notifyListeners();
  }

  void addMessageGemini() {
    _results.add(MessageModel(
        message: '', image: null, typeMessage: TypeMessage.gemini));

    notifyListeners();
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<List<MessageModel>> responGemini(String message) async {
    addMessageUser(message, null);
    addMessageGemini();
    log(numberElement.toString());

    setLoading(true);
    log('Start Gemini');
    if (apiKey.isEmpty) {
      log('API KEY NOT FOUND');
    }

    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final content = [Content.text(message)];

      final response = model.generateContentStream(content);
      String combinedMessage = "";

      await for (final output in response) {
        setLoading(false);
        combinedMessage += output.text.toString();
        _results[numberElement] = MessageModel(
            message: combinedMessage,
            image: null,
            typeMessage: TypeMessage.gemini);

        log(combinedMessage);
      }

      // setLoading(false);
      // Future.delayed(const Duration(milliseconds: 1000)).whenComplete(
      //   () {
      // _results.add(MessageModel(
      //     message: combinedMessage,
      //     image: null,
      //     typeMessage: TypeMessage.gemini));
      //     notifyListeners();
      //   },
      // );
    } catch (e) {
      log('Erorr: ${e.toString()}');
    }

    log('Have value on results stream? : ${results.length}');
    numberElement++;
    return results;
  }

  Future<void> responGeminiImage(String message, XFile image) async {
    addMessageUser(message, image);
    addMessageGemini();
    log('Start Gemini with image');

    setLoading(true);
    final bytesImage = await image.readAsBytes();
    var typeFile = lookupMimeType(image.path);
    String combinedMessage = "";

    if (apiKey == null) {
      log('API KEY NOT FOUND');
    }
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final prompt = TextPart(message);
    final dataImage = DataPart(typeFile!, bytesImage);

    // final response = await model.generateContent([
    //   Content.multi([prompt, dataImage])
    // ]);
    // log(response.text.toString());

    final response = await model.generateContentStream([
      Content.multi([prompt, dataImage])
    ]);

    await for (final output in response) {
      setLoading(false);
      combinedMessage += output.text.toString();
      _results[numberElement] = MessageModel(
          message: combinedMessage,
          image: null,
          typeMessage: TypeMessage.gemini);
    }

    // setLoading(false);
    // _results.add(MessageModel(
    //     message: combinedMessage,
    //     image: null,
    //     typeMessage: TypeMessage.gemini));

    notifyListeners();
    numberElement++;
  }
}
