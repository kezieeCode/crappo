import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/views/home.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
  }) : super(key: key);

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
                    "Interest Balance",
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
                children: const [
                  SizedBox(
                    width: 70,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 4),
                    child: Text("USD"),
                  ),
                  Text("\$23,000",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: 32, right: 20),
                child: Text(
                  "Withdrawable on maturity",
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
