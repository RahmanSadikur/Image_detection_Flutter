import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cats VS Dogs",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        seconds: 14,
        navigateAfterSeconds: new HomeScreen(),
        title: new Text(
          'Welcome In SplashScreen',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: new Image.asset('assets/images/1.jpg'),
        backgroundColor: Colors.white,
        loaderColor: Colors.red,
      ),
    );
  }
}
