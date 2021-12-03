import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/homescreen.dart';
import 'package:rent_app/login.dart';
import 'package:rent_app/models/RegisterUserResponse.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/register.dart';
import 'package:rent_app/searchpage.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/ProgressHUD.dart';
import 'package:rent_app/utils/preferences.dart';
import 'package:rent_app/verifyotp.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class ForgotPasswordPage extends StatefulWidget{
  String? email;
  ForgotPasswordPage({Key? key, this.email}) : super(key: key);
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}
class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool _isHidden = true;
  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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
             child: SvgPicture.asset('assets/icon_back.svg', semanticsLabel: 'Back', height: 34, width: 35))
            ]));
  }

  Widget contentWidget() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: Form(key: formKey,
                child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child:
                      SvgPicture.asset('assets/icon_forgotpass.svg', semanticsLabel: 'Forgot Password', height: 88, width: 77)
                      ),
                      SizedBox(height: 30),
                      Center(child:Text('Forgot Password',textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontFamily: "Nunito-Bold"))),
                      SizedBox(height: 10),
                      Center(child:Text('Select which contact detail should we use to reset your password.', textAlign: TextAlign.center,style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular"))),
                      SizedBox(height: 30),
                      Container(height:98,
                          child:  Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: HexColor('#EEEEEF'),
                            elevation: 1,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    this.showToast('Coming Soon...');

                                  });
                                },
                                child : Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: Row(crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                    SvgPicture.asset('assets/icon_mobile.svg', semanticsLabel: 'Mobile', height: 49, width: 47),
                                    SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child : Column(crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                      Text('Via SMS', style: TextStyle(color: HexColor('#888892'),fontSize: 16, fontFamily: "Nunito-Regular")),
                                      Text('**********', style: TextStyle(color: HexColor('#454555'),fontSize: 18, fontFamily: "Nunito-Bold")),
                                    ]))

                                  ],),
                                )),
                          )),
                      SizedBox(height: 30),
                      Container(height:98,
                          child:  Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: HexColor('#EEEEEF'),
                            elevation: 1,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  forgotPassword();
                                },
                                child : Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: Row(crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset('assets/icon_mailbox.svg', semanticsLabel: 'Mobile', height: 49, width: 47),
                                      SizedBox(height: 20),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          child : Column(crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                Text('Via Email', style: TextStyle(color: HexColor('#888892'),fontSize: 16, fontFamily: "Nunito-Regular")),
                                                Text(widget.email ?? '', style: TextStyle(color: HexColor('#454555'),fontSize: 18, fontFamily: "Nunito-Bold")),
                                              ]))

                                    ],),
                                )),
                          ))
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
  Future<void> forgotPassword() async {
    Map<String, String> data = {
      "email": widget.email ?? '',
    };

    ApiService.forgotPass(data).then((value) {
      setState(() {
        _isLoading = false;
      });
      if(value.success == true){
        this.showToast(value.message ?? '');
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOTPPage(email: widget.email)));
        });
      }
      else{
        this.showToast(value.errors ?? '');
      }

    });
  }
}
