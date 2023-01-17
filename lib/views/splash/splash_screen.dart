import 'package:crypto_tracker/onboard.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/res/color.dart';
import '../home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _startPage() async {
    final prefs = await SharedPreferences.getInstance();
    var checkSession = prefs.getString("logger");
    bool isLogged = false;
    if (checkSession != null) {
      isLogged = true;
    }
    Future.delayed(Duration(seconds: 5), () {
      if (isLogged == true) {
        print("yes i am logged");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        print("No i am not logged");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 130,
                    ),
                    const Text(
                      "CRAPPO",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Color.fromARGB(255, 30, 2, 35)),
                    )
                  ],
                ),
                const CircularProgressIndicator(
                  color: Color.fromARGB(255, 30, 2, 35),
                )
              ],
            ),
          ),
        ));
  }
}
