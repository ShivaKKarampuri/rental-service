import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rent_app/login.dart';
import 'package:rent_app/onboarding.dart';
import 'package:rent_app/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) {
    Preference.init();
    runApp(MyApp());
  });
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>     Preference?.getBool("onBoard") == true ? (Preference?.getString("userId")!.isNotEmpty ? MainScreen() : LoginPage()) : OnboardScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:Center(child: Image.asset(
          "assets/applogo.png",
          height: 60,
          width: 60,
        )),
    );
  }
}