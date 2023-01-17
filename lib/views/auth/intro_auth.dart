import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/views/auth/login.dart';
import 'package:crypto_tracker/views/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  _navigate(Widget child) {
    return Navigator.push(
        context,
        PageTransition(
            child: child,
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 500)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [AppColors.bgColor, Color.fromARGB(255, 27, 38, 95)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.4, 0.7],
            tileMode: TileMode.repeated,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 25.h,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      color: Colors.white,
                      width: 100,
                    ),
                    Text(
                      "Crappo".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.w),
                child: const Text(
                  "Welcome",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.w, left: 7.w),
                child: const Text(
                  "Easy way to manage your investment, without anxiety.",
                  style: TextStyle(height: 2, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  width: 100.w,
                  height: 9.h,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.white,
                    onPressed: () {
                      _navigate(LoginScreen());
                      print("here");
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          // fontSize: 20,
                          color: Color.fromARGB(255, 16, 25, 67),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              InkWell(
                onTap: () {
                  _navigate(RegisterScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  child: Container(
                    width: 100.w,
                    height: 9.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
