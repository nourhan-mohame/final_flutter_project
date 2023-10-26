import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'first_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200, // Reduce the height of the Image.asset() widget.
                width: 200,
                child: Image.asset('assets/contacts.gif'),
              ),
              Column(
                children: [
                  Text(
                    "Contacts",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        nextScreen: First_Screen(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.white,
        duration: 3000,
      ),
    );
  }
}
