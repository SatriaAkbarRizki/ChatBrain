import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speakai/databases/storevalue.dart';
import 'package:speakai/view/home.dart';

class SplashScreens extends StatelessWidget {
  final Storevalue _storevalue = Storevalue();
  SplashScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ChatBrain',
          style: TextStyle(
              fontFamily: 'intern_tight', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/illustration/taskscomplete.svg',
                      width: MediaQuery.of(context).size.width / 1.35,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      'Get Experince & Fast Respons \nwith ChatBrain',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontFamily: 'Satoshi'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Future.delayed(const Duration(milliseconds: 500));
                      await _storevalue.write(true).then(
                            (value) => Navigator.of(context)
                                .pushReplacement(createPageRoute()),
                          );
                    },
                    overlayColor: WidgetStateColor.transparent,
                    child: Container(
                      height: 50,
                      width: 100,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'Continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Satoshi',
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'ChatBrain using Gemini AI',
                style: TextStyle(fontSize: 11, fontFamily: 'intern_tight'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route createPageRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreens(),
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: Curves.ease));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        });
  }
}
