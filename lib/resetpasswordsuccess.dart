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
class ResetPasswordSuccessPage extends StatefulWidget{
  ResetPasswordSuccessPage({Key? key}) : super(key: key);
  @override
  ResetPasswordSuccessPageState createState() => ResetPasswordSuccessPageState();
}
class ResetPasswordSuccessPageState extends State<ResetPasswordSuccessPage> {
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
                Container(height:70, child:footerWidget()),
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

  Widget footerWidget(){
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
    child:SizedBox(
        width: double.infinity,
        height: 48,
        child: TextButton(
          child: Text("Login",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Nunito-Regular")),
          style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor:
              HexColor("F1635D"),
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                      48.0),
                  side: BorderSide(
                      color: HexColor(
                          "F1635D")))),
          onPressed: () {
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => LoginPage(),
              ),
                  (route) => false,//if you want to disable back feature set to false
            );          },
        )));
  }

  Widget contentWidget() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: Form(key: formKey,
                child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child:
                      SvgPicture.asset('assets/icon_rs_success.svg', semanticsLabel: 'otp', height: 90, width: 80)
                      ),
                      SizedBox(height: 30),
                      Center(child:Text('Password reset',textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontFamily: "Nunito-Bold"))),
                      Center(child:Text('successful!',textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontFamily: "Nunito-Bold"))),
                      SizedBox(height: 20),
                      Center(child:Text('Now login with newly created password', textAlign: TextAlign.center,style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular"))),
                      SizedBox(height: 30),

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

}
