import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:speakai/service/pickimage.dart';
import 'package:speakai/service/previewimage.dart';
import 'package:speakai/widget/bottom_search.dart';
import 'package:speakai/widget/chats.dart';
import 'package:speakai/widget/welcome.dart';
import '../presenter/gemini.dart';
import '../service/voicemesseger.dart';
import '../widget/loading.dart';
import 'dart:ui' as ui;

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final image = Provider.of<PickImageUser>(context);
    final previewImage = Provider.of<PreviewImage>(context);
    final voicemesseger = Provider.of<Voicemesseger>(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('ChatBrain',
            style: TextStyle(
                fontFamily: 'intern_tight', fontWeight: FontWeight.w600)),
      ),
      body: Stack(
        children: [
          Consumer<GeminiAi>(
            builder: (context, value, child) {
              if (value.results.isEmpty) {
                return const Welcome();
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const Chats(),
                      AnimatedOpacity(
                          opacity: value.isLoading == true ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: const LoadingWidget())
                    ],
                  ),
                );
              }
            },
          ),
          Hero(
            tag: 'image-preview',
            child: Visibility(
              visible: previewImage.showing,
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 60, bottom: 20),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text("Delete"),
                        onPressed: () {
                          previewImage.setPreview(false);
                          image.removeImage();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 250,
                        margin: const EdgeInsets.only(
                            left: 60, right: 60, bottom: 80),
                        decoration: BoxDecoration(
                          image: image.image != null
                              ? DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FileImage(File(image.image!.path)))
                              : null,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: voicemesseger.isPreview,
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(left: 60, bottom: 20),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.close_rounded),
                      label: const Text("Close"),
                      onPressed: () {
                        voicemesseger.setPreview(false);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    overlayColor: WidgetStateColor.transparent,
                    onTap: () {
                      voicemesseger.setAnimate(false);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 250,
                        margin: const EdgeInsets.only(
                            left: 60, right: 60, bottom: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xff111111),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Lottie.asset(
                          'assets/Animation/Animation_voice.json',
                          animate: voicemesseger.isAnimate,
                          repeat: true,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      'Tap to Stop Recording',
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Satoshi'),
                    ),
                  )
                ],
              ),
            ),
          ),
          const BottomSearch(),
        ],
      ),
    );
  }
}
