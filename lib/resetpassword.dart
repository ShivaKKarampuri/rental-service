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
import 'package:rent_app/resetpasswordsuccess.dart';
import 'package:rent_app/searchpage.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/ProgressHUD.dart';
import 'package:rent_app/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class ResetPasswordPage extends StatefulWidget{
  String? userId;
  ResetPasswordPage({Key? key, this.userId}) : super(key: key);
  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}
class ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _isHidden = true;
  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  TextEditingController password = new TextEditingController();
  TextEditingController passwordAgain = new TextEditingController();



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
            resizeToAvoidBottomInset: false,
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
                      SvgPicture.asset('assets/icon_forgotpass.svg', semanticsLabel: 'Reset Password', height: 88, width: 77)
                      ),
                      SizedBox(height: 30),
                      Center(child:Text('Reset Password',textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontFamily: "Nunito-Bold"))),
                      SizedBox(height: 10),
                      Center(child:Text('Now reset your own password.', textAlign: TextAlign.center,style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular"))),
                      SizedBox(height: 30),
                      Text('Password', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                      SizedBox(height: 10),
                      Container(height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:BorderRadius.circular(
                                4.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                              controller: password,
                              obscureText: _isHidden,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                                border: OutlineInputBorder(),
                                suffix: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child :Icon(_isHidden ? Icons.visibility : Icons.visibility_off,
                                          size: 22.0)),
                                ),
                                hintText: 'johndoe',
                              ))),
                      SizedBox(height: 15),
                      Text('Password Again', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                      SizedBox(height: 10),
                      Container(height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:BorderRadius.circular(
                                4.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                              controller: passwordAgain,
                              obscureText: _isHidden,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                                border: OutlineInputBorder(),
                                suffix: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child :Icon(_isHidden ? Icons.visibility : Icons.visibility_off,
                                          size: 22.0)),
                                ),
                                hintText: 'johndoe',
                              ))),
                      SizedBox(height: 20),
                      SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: TextButton(
                            child: Text("Submit",
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
                              submitForm();
                            },
                          )),
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

  void submitForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    } else {
      bool passValid = RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*").hasMatch(password.text);
      bool rpassValid = RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*").hasMatch(passwordAgain.text);


      if(password.text.isEmpty){
        this.showToast("Please enter password");
      }
      else if(!passValid){
        this.showToast("Password must contain 1 uppercase, 1 lowercase, 1 numeric number, 1 special character");
      }
      else if(passwordAgain.text.isEmpty){
        this.showToast("Please enter password again");
      }
      else if(!rpassValid){
        this.showToast("Password again must contain 1 uppercase, 1 lowercase, 1 numeric number, 1 special character");
      }
      else if(password.text != passwordAgain.text){
        this.showToast("Please check both passwords");
      }
      else{
        setState(() {
          _isLoading = true;
        });
        resetPassword();
      }

    }
  }

  Future<void> resetPassword() async {
    Map<String, String> data = {
      "user_id": widget!.userId!,
      "password": password.text,
      "password_confirmation": passwordAgain.text,
    };

    ApiService.resetPassword(data).then((value) {
      setState(() {
        _isLoading = false;
      });
      if(value.success == true){
        this.showToast(value.message ?? '');
        setState(() {
          formKey.currentState?.reset();
          this.password.clear();
          this.passwordAgain.clear();
          FocusScope.of(context).unfocus();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResetPasswordSuccessPage()));
        });
      }
      else{
        this.showToast(value.errors ?? '');
      }
    });
  }
}
