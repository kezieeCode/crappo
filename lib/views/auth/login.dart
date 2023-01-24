import 'dart:convert';

import 'package:crypto_tracker/views/home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

startSession() async {
  final prefs = await SharedPreferences.getInstance();
  var loginSession = prefs.setString("logger", "loggged");
  return loginSession;
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String loginButtonText = "Login";
  Future loginUser(BuildContext context) async {
    setState(() {
      loginButtonText = "Please Wait";
    });
    var uri = 'https://crappo.000webhostapp.com/apis/get/login.php';
    var data = {
      "email": _emailController.text,
      "password": _passwordController.text
    };

    var response = await http.get(
      Uri.parse(uri).replace(queryParameters: data),
    );
    if (response.statusCode == 200) {
      var newresponse = jsonDecode(response.body)['status'];

      print(response.body);
      if (newresponse == 3) {
        var uId = jsonDecode(response.body)['id'];
        final prefs = await SharedPreferences.getInstance();
        var u_Id = prefs.setString("user_id", uId);
        // var usersId = prefs.getString("user_id");
        startSession();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          onConfirmBtnTap: () {
            // print(usersId);
            _navigate(HomeScreen());
          },
          title: 'Welcome',
          text:
              'Welcome back to crappo, the best crypto investment platform you can trust',
        );
      } else if (newresponse == 1) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          onConfirmBtnTap: () {
            Navigator.pop(context);
          },
          title: 'Invalid Email',
          text: 'Email is required',
        );
      } else if (newresponse == 2) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          onConfirmBtnTap: () {
            Navigator.pop(context);
          },
          title: 'Invalid password',
          text: 'Password is required',
        );
      } else if (newresponse == 4) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          onConfirmBtnTap: () {
            Navigator.pop(context);
          },
          title: 'Mispelt details',
          text: 'Check properly',
        );
      }
      // _navigate(const HomeScreen());

    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        onConfirmBtnTap: () {
          Navigator.pop(context);
        },
        title: 'Error',
        text:
            'There was an error while logging you in please confirm details properly',
      );
      print(response.body);
    }
  }

  final gradient = const LinearGradient(
    colors: [Colors.pink, Colors.green],
  );
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
      body: ListView(
        children: [
          SizedBox(
            height: 4.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 4.w,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Text(
                  "Login".toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
              )
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Hello",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: <Color>[
                          Colors.purple,
                          Colors.white
                          // Colors.red
                          //add more color here.
                        ],
                      ).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)))),
          ),
          const Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Login first to continue",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 4.w),
            child: Text("Email"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                  suffixIcon: Icon(
                Icons.email_outlined,
                color: Colors.white,
              )),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 4.w),
            child: Text("Password"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w),
            child: TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                  suffixIcon: Icon(
                Icons.security_outlined,
                color: Colors.white,
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 65.w, top: 4.h),
            child: Text("Forgot Password?"),
          ),
          SizedBox(
            height: 7.h,
          ),
          InkWell(
            onTap: () {
              loginUser(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 4.w, right: 4.w),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Colors.purple,
                        Colors.purpleAccent,
                        Colors.purple
                        //add more color here.
                      ],
                    )),
                height: 70,
                child: Center(
                  child: Text(
                    loginButtonText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
