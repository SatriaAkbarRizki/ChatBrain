
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:speakai/enum/typemessage.dart';
import 'package:speakai/model/message.dart';
import 'package:speakai/presenter/gemini.dart';

class ChatSpeakai extends StatelessWidget {
  final List message = [];
  ChatSpeakai({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GeminiAi>(
      builder: (context, value, child) {
        // Collect user messages
        List<MessageModel> userMessages = value.results
            .where((message) => message.typeMessage == TypeMessage.user)
            .toList();

        // Collect Gemini messages

        List<MessageModel> geminiMessages = value.results
            .where((message) => message.typeMessage == TypeMessage.gemini)
            .toList();

        String combinedGeminiMessages =
            geminiMessages.map((e) => e.message).join();

        return ListView.builder(
          itemCount: userMessages.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => Column(
            children: [
              Align(
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
                      const Text('SpeakAI'),
                      Text(combinedGeminiMessages),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}



// Consumer<GeminiAi>(
//       builder: (context, value, child) {
//         value.results
//             .map(
//               (e) => message.add(e.message.toString()),
//             )
//             .toList();
//         message.join();
//         log(message[1].toString());
//         return ListView.builder(
//           shrinkWrap: true,
//           itemCount: value.results.length,
//           itemBuilder: (context, index) => value.results[index].typeMessage ==
//                   TypeMessage.gemini
//               ? Align(
//                   alignment: Alignment.topRight,
//                   child: Container(
//                     margin: const EdgeInsets.only(left: 15, right: 15, top: 25),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             color: const Color(0xff2a53ed), width: 2.0),
//                         borderRadius: BorderRadius.circular(25)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('SpeakAI'),
//                         Text(value.results[index].message)
//                       ],
//                     ),
//                   ),
//                 )
//               : SizedBox(),
//         );
//       },
//     )