import 'package:crypto_tracker/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class WithdrawalDetails extends StatefulWidget {
  final title;
  const WithdrawalDetails({Key key, this.title}) : super(key: key);

  @override
  State<WithdrawalDetails> createState() => _WithdrawalDetailsState();
}

final amountController = TextEditingController();

class _WithdrawalDetailsState extends State<WithdrawalDetails> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          sensitiveTransaction: true,
          stickyAuth: true,
          useErrorDialogs: true,
          biometricOnly: true,
        ),
      );
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        onConfirmBtnTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        title: 'Withdraw successful',
        text: 'Crappo credits you in the next 10 minutes',
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
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
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  widget.title.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
              )
            ],
          ),
          Center(child: Image.asset("assets/images/getmoney.png")),
          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w),
            child: TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.currency_exchange,
                    color: Colors.purpleAccent,
                  ),
                  hintText: "Input Amount",
                  hintStyle: TextStyle(color: Colors.purpleAccent),
                  border: OutlineInputBorder()),
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
                  suffixIcon: Icon(
                    Icons.currency_bitcoin,
                    color: Colors.purpleAccent,
                  ),
                  hintText: "Address",
                  hintStyle: TextStyle(color: Colors.purpleAccent),
                  border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Container(
              height: 6.h,
              child: MaterialButton(
                  color: const Color.fromARGB(255, 105, 5, 123),
                  onPressed: _authenticateWithBiometrics,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Text("withdraw".toUpperCase()),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.fingerprint,
                        color: Colors.white,
                      )
                    ],
                  )),
            ),
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
