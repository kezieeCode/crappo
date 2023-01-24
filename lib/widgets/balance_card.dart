import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:sizer/sizer.dart';
import 'dart:math';
import '../core/res/color.dart';
import '../core/res/particles.dart';
import '../models/particle.dart';
import '../services/apis.dart';
import '../views/home.dart';
import 'credit_painter.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({Key key}) : super(key: key);

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(children: [
        const PositionedCircle(
          size: 240,
          left: -100,
          top: -100,
        ),
        const PositionedCircle(
          size: 220,
          bottom: -160,
          left: 55,
        ),
        const PositionedCircle(
          size: 180,
          top: -100,
          right: -100,
        ),
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.currency_exchange,
                    color: Colors.blue[100],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Deposited  Balance",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Row(
                children: [
                  SizedBox(
                    width: 70,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 4),
                    child: Text("USD"),
                  ),
                  FutureBuilder(
                      future: HttpService().userInfo(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Text("\$${snapshot.data['account_balance']}",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold));
                        } else if (snapshot.hasError) {
                          print(snapshot);
                          return const Text("N/A",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold));
                        } else {
                          // throw Exception();
                          return const JumpingDots(
                            numberOfDots: 3,
                            radius: 4,
                            color: Colors.white,
                          );
                        }
                      })
                  // Text("\$23,000",
                  //     style:
                  //         TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: 32, right: 20),
                child: Text(
                  "Daily deposit interest of 30% ",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
