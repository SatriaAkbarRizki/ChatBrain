import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speakai/service/pickimage.dart';
import 'package:speakai/service/voicemesseger.dart';

import '../service/previewimage.dart';

class CustomAction extends StatelessWidget {
  const CustomAction({super.key});

  @override
  Widget build(BuildContext context) {
    final pickImage = Provider.of<PickImageUser>(context);
    final previewImage = Provider.of<PreviewImage>(context);
    final voicemesseger = Provider.of<Voicemesseger>(context);

    return PopupMenuButton(
      offset: const Offset(0, -180),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () async => await pickImage.getImage().then(
            (value) {
              previewImage.setPreview(true);
              log('Value from Image: ${value.toString()}');
            },
          ),
          child: Row(
            children: [
              const Icon(Icons.image),
              Container(
                  width: 100,
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text('Image'))
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          onTap: () async => await pickImage.getFromCamera().then(
            (value) {
              previewImage.setPreview(true);
              log('Value from Camera: ${value.toString()}');
            },
          ),
          child: Row(
            children: [
              const Icon(Icons.camera_alt),
              Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text('Camera'))
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          onTap: () async => await voicemesseger.initSpeech().whenComplete(() {
            previewImage.setPreview(false);
            voicemesseger.setPreview(true);
          }),
          child: Row(
            children: [
              const Icon(Icons.mic),
              Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text('Voice'))
            ],
          ),
        )
      ],
    );
  }
}
