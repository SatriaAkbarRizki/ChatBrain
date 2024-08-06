import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speakai/presenter/gemini.dart';
import 'package:speakai/service/pickimage.dart';
import 'package:speakai/service/previewimage.dart';
import 'package:speakai/service/voicemesseger.dart';
import 'package:speakai/widget/custom_action.dart';

class BottomSearch extends StatefulWidget {
  const BottomSearch({super.key});

  @override
  State<BottomSearch> createState() => _BottomSearchState();
}

class _BottomSearchState extends State<BottomSearch> {
  final messageControl = TextEditingController();
  final focusKeyboard = FocusNode();

  String? message;

  @override
  void dispose() {
    focusKeyboard.dispose();
    messageControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final geminiAi = Provider.of<GeminiAi>(context, listen: false);
    final pickImage = Provider.of<PickImageUser>(context);
    final previewImage = Provider.of<PreviewImage>(context);
    final voicemesseger = Provider.of<Voicemesseger>(context);

    return Consumer<Voicemesseger>(
      builder: (context, value, child) {
        if (value.lastWord.isNotEmpty) {
          messageControl.text = value.lastWord;
          message = messageControl.text;
        }
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    focusNode: focusKeyboard,
                    controller: messageControl,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (value) => message = value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        backgroundColor: Colors.transparent),
                    decoration: InputDecoration(
                        prefixIcon: const CustomAction(),
                        filled: true,
                        fillColor: const Color(0xff616161),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25)),
                        hintText: 'Message Gemini Flutter',
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  log('value message: $message');
                  log('have Image? ${pickImage.image}');
                  focusKeyboard.unfocus();
                  messageControl.clear();
                  previewImage.setPreview(false);
                  voicemesseger.setPreview(false);
                  if (message != null) {
                    if (pickImage.image != null) {
                      await geminiAi.responGeminiImage(
                          message!, pickImage.image!);
                      message = null;
                      pickImage.removeImage();
                    } else {
                      await geminiAi.responGemini(message!);
                      message = null;
                    }
                  }
                },
                child: const Icon(
                  Icons.send,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15)),
              )
            ]),
          ),
        );
      },
    );
  }
}
