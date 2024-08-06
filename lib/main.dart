import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speakai/databases/storevalue.dart';
import 'package:speakai/presenter/gemini.dart';
import 'package:speakai/service/pickimage.dart';
import 'package:speakai/service/previewimage.dart';
import 'package:speakai/service/voicemesseger.dart';
import 'package:speakai/view/home.dart';
import 'package:speakai/view/splash.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final Storevalue storevalue = Storevalue();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GeminiAi(),
        ),
        ChangeNotifierProvider(
          create: (context) => PickImageUser(),
        ),
        ChangeNotifierProvider(
          create: (context) => PreviewImage(),
        ),
        ChangeNotifierProvider(
          create: (context) => Voicemesseger(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xff111111)),
            scaffoldBackgroundColor: const Color(0xff111111)),
        home: FutureBuilder(
            future: storevalue.read(),
            builder: (context, snapshot) =>
                snapshot.data == true ? const HomeScreens() : SplashScreens()),
      ),
    );
  }
}
