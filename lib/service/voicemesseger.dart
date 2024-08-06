import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Voicemesseger with ChangeNotifier {
  SpeechToText speechText = SpeechToText();
  bool speechEnabled = false, isPreview = false, isAnimate = true;
  String lastWord = '';

  Future initSpeech() async {
    speechEnabled = await speechText.initialize();
    notifyListeners();
  }

  void startSpeech() async {
    if (speechEnabled == false) await initSpeech();
    log('START: SPEECH');
    await speechText.listen(onResult: resultSpeech);
    notifyListeners();
  }

  void stopSpeech() async {
    await speechText.stop();
    log('STOP: SPEECH');
    log('Value: $lastWord');

    isAnimate = false;
    notifyListeners();
  }

  void resultSpeech(SpeechRecognitionResult results) {
    log('results: ${results.recognizedWords}');
    lastWord = results.recognizedWords;
    notifyListeners();
  }

  void setPreview(bool value) {
    isPreview = value;

    if (isPreview == false) {
      setAnimate(false);
      stopSpeech();
    } else {
      startSpeech();
      setAnimate(true);
    }
    notifyListeners();
  }

  void setAnimate(bool value) {
    isAnimate = value;
    notifyListeners();
  }
}
