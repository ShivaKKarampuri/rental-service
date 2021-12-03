import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rent_app/homescreen.dart';
import 'package:rent_app/login.dart';
import 'package:rent_app/models/RegisterUserResponse.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/register.dart';
import 'package:rent_app/resetpassword.dart';
import 'package:rent_app/searchpage.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/ProgressHUD.dart';
import 'package:rent_app/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class VerifyOTPPage extends StatefulWidget{
  String? email;
  VerifyOTPPage({Key? key, this.email}) : super(key: key);
  @override
  VerifyOTPPageState createState() => VerifyOTPPageState();
}
class VerifyOTPPageState extends State<VerifyOTPPage> {
  bool _isHidden = true;
  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: HexColor('#EEEEEF'),
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(5.0),
    );
  }
  @override
  void initState() {
    super.initState();
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home :  Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading:  IconButton(
                icon: Icon(Icons.chevron_left_outlined, size: 38),
                tooltip: 'Back Icon', color: HexColor('454555'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              brightness: Brightness.dark,
            ),
            backgroundColor: HexColor('FFFFFF'),
            body: ProgressHUD(
              child:  Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                Container(height: 0,color: Colors.transparent, child: headerWidget()),
                Expanded(child: contentWidget()),
                Container(height: 0),
              ]),
              inAsyncCall: _isLoading,
              opacity: 0.0,
            )
        ));

  }
  Widget headerWidget(){
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(onTap:() {
                Navigator.pop(context);
              },
                  child: SvgPicture.asset('assets/icon_back.svg', semanticsLabel: 'Back', height: 34, width: 35))            ]));
  }

  Widget contentWidget() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: Form(key: formKey,
                child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child:
                      SvgPicture.asset('assets/icon_verifyotp.svg', semanticsLabel: 'otp', height: 90, width: 80)
                      ),
                      SizedBox(height: 30),
                      Center(child:Text('Enter 5 digit code',textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontFamily: "Nunito-Bold"))),
                      SizedBox(height: 10),
                      Center(child:Text('The code was sent your mobile number.Please enter code', textAlign: TextAlign.center,style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular"))),
                      SizedBox(height: 30),
              PinPut(
                fieldsCount: 5,
                withCursor: true,
                fieldsAlignment: MainAxisAlignment.spaceAround,
                textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
                eachFieldMargin: EdgeInsets.all(0),
                eachFieldWidth: 57.0,
                eachFieldHeight: 57.0,
                onSubmit: (String pin) => verifyOTP(widget.email ?? '', pin, context),
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: _pinPutDecoration.copyWith(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Colors.red,
                  ),
                ),
                selectedFieldDecoration: _pinPutDecoration,
                followingFieldDecoration: _pinPutDecoration.copyWith(
                  color: HexColor('#EEEEEF'),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
                    ]))

        ));
  }


  void showToast(String msg)
  {
    Toast.show(msg, context);
    Timer(Duration(seconds: 3), () {
      Toast.dismiss();
    });
  }

  verifyOTP(String email, String pin, BuildContext context) {
    _pinPutFocusNode.unfocus();
    setState(() {
      _isLoading = true;
    });

    // if(pin.isEmpty){
    //   this.showToast('Please enter 4 digit code');
    // }
    // else{
      Map<String, String> data = {
        "email": email,
        "otp": pin,
      };

      print(data);
      ApiService.verifyOTP(data).then((value) {
        setState(() {
          _isLoading = false;
          _pinPutController.clear();
        });
        if(value.success == true){
          this.showToast(value.message ?? '');
          setState(() {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResetPasswordPage(userId: value.user?.id.toString() ?? '')));
          });
        }
        else{
          this.showToast(value.errors ?? '');
        }

      });
  //  }
  }
}
