import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/views/home.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:quickalert/quickalert.dart';

class DetailScreen extends StatefulWidget {
  final bitAdress;
  const DetailScreen({Key key, this.bitAdress}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

final amountController = TextEditingController();

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
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
                  "Deposit".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: QrImage(
              data: widget.bitAdress,
              size: 200,
              foregroundColor: Colors.white,
            ),
          ),
          const Center(
            child: Text("Scan Qr code"),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w),
            child: TextFormField(
              decoration: InputDecoration(
                  suffixIcon: Container(
                    color: Color.fromARGB(255, 105, 5, 123),
                    width: 60,
                    height: 60,
                    child: Center(child: Text("Copy")),
                  ),
                  hintText: widget.bitAdress,
                  hintStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w),
            child: TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.currency_exchange),
                  hintText: "Input Amount",
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Container(
              height: 10.h,
              child: MaterialButton(
                  color: Color.fromARGB(255, 105, 5, 123),
                  onPressed: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.info,
                      onConfirmBtnTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      title: 'Deposit pending',
                      text: 'Crappo credits you in the next 10 minutes',
                    );
                  },
                  child: Text("Dpeosit complete".toUpperCase())),
            ),
          )
        ],
      ),
    );
  }
}
