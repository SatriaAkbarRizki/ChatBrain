import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speakai/enum/typemessage.dart';
import 'package:speakai/presenter/gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GeminiAi>(
      builder: (context, response, child) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: response.results.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (response.results[index].typeMessage == TypeMessage.user) {
            return Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 300,
                margin: const EdgeInsets.only(top: 25, right: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xff83aeb7), width: 2.0),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        'You',
                        style: TextStyle(fontFamily: 'intern_tight'),
                      ),
                    ),
                    Hero(
                      tag: 'image-preview',
                      child: Visibility(
                        visible: response.results[index].image != null
                            ? true
                            : false,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 250,
                            margin: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 15, top: 10),
                            decoration: BoxDecoration(
                              image: response.results[index].image != null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(
                                          response.results[index].image!.path)))
                                  : null,
                              border: Border.all(
                                  color: const Color(0xff83aeb7), width: 2.0),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        response.results[index].message,
                        style: const TextStyle(
                            fontFamily: 'Satoshi',
                            wordSpacing: 1.5,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            if (response.results[index].message.isEmpty) {
              return const SizedBox();
            }
            return AnimatedOpacity(
              opacity: response.results[index].typeMessage == TypeMessage.user
                  ? 0.0
                  : 1.0,
              duration: const Duration(milliseconds: 1000),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 25),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xff2a53ed), width: 2.0),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ChatBrain',
                          style: TextStyle(fontFamily: 'intern_tight')),
                      Markdown(
                          padding: const EdgeInsets.only(left: 0, top: 10),
                          selectable: true,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          data: response.results[index].message),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
