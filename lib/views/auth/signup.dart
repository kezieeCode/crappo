import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:crypto_tracker/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

String countryString = "Select a country";

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future registerUser(BuildContext context) async {
    var uri = 'https://crappo.000webhostapp.com/apis/post/signup.php';
    var data = {
      "full_name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text
    };
    print(data);
    var response = await http.post(
      Uri.parse(uri),
      body: data,
    );
    // var newresponse = jsonDecode(response.body)['status'];
    if (response.statusCode == 200) {
      print(response.body);
      // if (newresponse == true) {
      //   print(response.body);
      // } else if (newresponse == false) {
      //   print(response.body);
      // }
    } else {
      throw Exception();
    }
  }

  _navigate(Widget child) {
    return Navigator.push(
        context,
        PageTransition(
            child: child,
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 500)));
  }

  setCountry() async {
    final prefs = await SharedPreferences.getInstance();
    var selectedCountry = prefs.getString("selectedCountry");
    setState(() {
      countryString = selectedCountry;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                  "register".toUpperCase(),
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
              "Signup first to start.",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 4.w),
            child: Text("Full name"),
          ),
          _buildFormField(
              const Icon(
                Icons.person,
                color: Colors.white,
              ),
              nameController),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 4.w),
            child: Text("Email"),
          ),
          _buildFormField(
              const Icon(
                Icons.email_outlined,
                color: Colors.white,
              ),
              emailController),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w, bottom: 15),
            child: const Text(
              "Select country",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w),
            child: SizedBox(
              // width: 500.w,
              height: 10.h,
              child: MaterialButton(
                color: Color.fromARGB(255, 231, 230, 230),
                onPressed: () {
                  showCountryPicker(
                      context: context,
                      countryListTheme: CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 16, color: Colors.blueGrey),
                        bottomSheetHeight:
                            500, // Optional. Country list modal height
                        //Optional. Sets the border radius for the bottomsheet.
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        //Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      onSelect: (
                        Country country,
                      ) async {
                        String selectedcountry = "${country.displayName}";
                        setState(() {
                          countryString = selectedcountry;
                        });
                        print('Select country: ${country.displayName}');
                      });
                },
                child: Text(
                  countryString,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.purple),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w, top: 15),
            child: Text("Password"),
          ),
          _buildFormField(
              const Icon(Icons.security_outlined, color: Colors.white),
              passwordController),
          SizedBox(
            height: 7.h,
          ),
          InkWell(
            onTap: () {
              registerUser(context);
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
                child: const Center(
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(left: 25.w, top: 2.h),
              child: Text("Already have an account?, Login"),
            ),
          ),
          SizedBox(
            height: 4.h,
          )
        ],
      ),
    );
  }

  Widget _buildFormField(Icon iconType, TextEditingController _textController) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, right: 4.w),
      child: TextFormField(
        controller: _textController,
        decoration: InputDecoration(suffixIcon: iconType),
      ),
    );
  }
}
