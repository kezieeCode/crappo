import 'package:crypto_tracker/views/withdraw/withdraw_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({Key key}) : super(key: key);

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
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
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  "Withdraw".toUpperCase(),
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
          InkWell(
            onTap: () {},
            child: _buildCardInformation(
                Colors.orange,
                "Bitcoin",
                Icon(
                  Icons.currency_bitcoin_sharp,
                  size: 30.sp,
                ),
                "Withdraw BTC"),
          ),
          SizedBox(height: 6.h),
          InkWell(
            onTap: () {},
            child: _buildCardInformation(
                Colors.blue,
                'Etherum',
                Image.asset(
                  "assets/images/ethereum.png",
                  width: 10.w,
                ),
                "Withdraw ETH"),
          ),
          SizedBox(height: 6.h),
          InkWell(
            onTap: () {},
            child: _buildCardInformation(
                Colors.white,
                "BNB",
                Image.asset(
                  "assets/images/bnb.png",
                  width: 10.w,
                ),
                "Withdraw BNB"),
          ),
          SizedBox(
            height: 6.h,
          ),
          InkWell(
            onTap: () {},
            child: _buildCardInformation(
                Colors.white,
                "Cardano",
                Image.asset(
                  "assets/images/cardano.png",
                  width: 10.w,
                ),
                "Withdraw CAD"),
          ),
          SizedBox(
            height: 6.h,
          ),
          InkWell(
            onTap: () {},
            child: _buildCardInformation(
                Colors.white,
                "Dodge",
                Image.asset("assets/images/dodge.png", width: 10.w),
                "Withdraw DOGE"),
          )
        ],
      ),
    );
  }

  _navigate(Widget child) {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.leftToRight, child: child));
  }

  Widget _buildCardInformation(Color circleColors, String leadingTitle,
      Widget iconType, String titleText) {
    return InkWell(
      onTap: () {
        _navigate(WithdrawalDetails(
          title: titleText,
        ));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 15, 21, 52),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 45, 40, 146),
                offset: Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Color.fromARGB(255, 20, 11, 144),
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: ListTile(
            leading: Container(
              decoration:
                  BoxDecoration(color: circleColors, shape: BoxShape.circle),
              child: iconType,
            ),
            title: Text(leadingTitle),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
