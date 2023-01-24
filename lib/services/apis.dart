import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/home.dart';

class HttpService {
  Future userInfo() async {
    final pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");
    var uri = 'https://crappo.000webhostapp.com/apis/get/get_user.php';
    var data = {"id": user_id};
    var response =
        await http.get(Uri.parse(uri).replace(queryParameters: data));
    var results = json.decode(response.body);
    if (response.statusCode == 200) {
      // print(user_id);
      // print(response.body);
      return results;
    } else {
      throw Exception();
    }
  }

  Future depositAmount(
    BuildContext context,
    String coin_type,
    TextEditingController address,
    TextEditingController deposit_amount,
  ) async {
    final pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");
    var uri = "https://crappo.000webhostapp.com/apis/post/deposit_request.php";
    var data = {
      "user_id": user_id,
      "coin_type": coin_type,
      "address": address.text,
      "deposit_amount": deposit_amount.text
    };
    var response = await http.post(Uri.parse(uri),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(data));
    if (response.statusCode == 200) {
      print(response.body);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        onConfirmBtnTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        title: 'Deposit pending',
        text: 'Crappo credits you in the next 10 minutes',
      );
    } else {
      print(response.body);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        onConfirmBtnTap: () {
          Navigator.pop(context);
        },
        title: 'Deposit Unsuccessful',
        text: 'Check details properly',
      );
    }
  }

  Future withdrawtAmount(
    BuildContext context,
    String coin_type,
    TextEditingController address,
    TextEditingController amount,
  ) async {
    final pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");
    var uri = "https://crappo.000webhostapp.com/apis/post/withdraw.php";
    var data = {
      "id": user_id,
      "coin_type": coin_type,
      "address": address.text,
      "withdrawal_amount": amount.text
    };
    var response = await http.post(Uri.parse(uri),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(data));
    if (response.statusCode == 200) {
      print(response.body);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        onConfirmBtnTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        title: 'Deposit pending',
        text: 'Crappo credits you in the next 10 minutes',
      );
    } else {
      print(response.body);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        onConfirmBtnTap: () {
          Navigator.pop(context);
        },
        title: 'Deposit Unsuccessful',
        text: 'Check details properly',
      );
    }
  }
}
