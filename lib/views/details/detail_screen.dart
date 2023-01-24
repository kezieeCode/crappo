import 'package:crypto_tracker/core/res/color.dart';
import 'package:crypto_tracker/services/apis.dart';
import 'package:crypto_tracker/views/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:quickalert/quickalert.dart';

class DetailScreen extends StatefulWidget {
  final coin_type;
  final bitAdress;
  const DetailScreen({Key key, this.bitAdress, this.coin_type})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

final amountController = TextEditingController();
final addressController = TextEditingController();

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
              padding: EdgeInsets.only(left: 10.w, right: 4.w),
              child: Row(
                children: [
                  SizedBox(width: 300, child: Text(widget.bitAdress)),
                  IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: widget.bitAdress))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("address copied to clipboard")));
                        });
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.white,
                      ))
                ],
              )),
          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w),
            child: TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                  hintText: "Paste the depositing address",
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
                    HttpService()
                        .depositAmount(context, widget.coin_type,
                            addressController, amountController)
                        .then((value) {
                      //This makes sure the textfield is cleared after page is pushed.
                      addressController.clear();
                      amountController.clear();
                    });
                  },
                  child: Text("Dpeosit complete".toUpperCase())),
            ),
          )
        ],
      ),
    );
  }
}
