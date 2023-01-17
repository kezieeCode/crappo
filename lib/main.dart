import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/core/routes/routes.dart';
import 'package:crypto_tracker/onboard.dart';
import 'package:crypto_tracker/views/coin.dart';
import 'package:crypto_tracker/views/home.dart';
import 'package:crypto_tracker/views/home/dashboard.dart';
import 'package:crypto_tracker/views/home/market.dart';
import 'package:crypto_tracker/views/home/portfolio.dart';
import 'package:crypto_tracker/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Task Management',
        debugShowCheckedModeBanner: false,
        theme: AppColors.getTheme,
        // initialRoute: Routes.home,
        home: const SplashScreen(),
        // initialRoute: Routes.home,
        // onGenerateRoute: RouterGenerator.generateRoutes,
      );
    });
  }
}
