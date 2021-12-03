import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/homescreen.dart';
import 'package:rent_app/login.dart';
import 'package:rent_app/models/RegisterUserResponse.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/searchpage.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/ProgressHUD.dart';
import 'package:rent_app/utils/preferences.dart';

class RegisterPage extends StatefulWidget{
  @override
  RegisterPageState createState() => RegisterPageState();
}
class RegisterPageState extends State<RegisterPage> {
  bool _isHidden = true;
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController forgotUsername = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController passwordAgain = new TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool _isLoading = false;

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
            backgroundColor: HexColor('FFFFFF'),
          body: ProgressHUD(
            child:  Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
              Container(height: 0),
              Expanded(child:  contentWidget()),
              Container(height: 60, child: footerWidget()),
            ]),
            inAsyncCall: _isLoading,
            opacity: 0.0,
          )


        ));

  }

  Widget footerWidget() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      5.0, 0, 5, 0),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      } ,
                  child : Text("Have an account?",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Nunito-Regular"))))),
              Center(child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      5.0, 0, 5, 0),
                  child: InkWell(
    onTap: () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } ,
                  child : Text("Log in",
                      style: TextStyle(
                          color: HexColor("F1635D"), fontSize: 16,
                          fontFamily: "Nunito-Regular"))))),
            ]));
  }

  Widget contentWidget() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: Form(key: formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Center(child: Image.asset(
                    "assets/applogo.png",
                    height: 60,
                    width: 60,
                  )),
                  SizedBox(height: 30),
                  Center(child:Text('Sign up!',textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontFamily: "Nunito-Bold"))),
                  SizedBox(height: 10),
                  Center(child:Text('Create an account to get start', textAlign: TextAlign.center,style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular"))),
                  SizedBox(height: 20,),
                  Text('First name', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  Container(height:48,
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
                      child:  TextFormField(
                      controller: firstName,
                          textInputAction: TextInputAction.next,
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
                        hintText: 'john',
                      ))),
                  SizedBox(height: 15),
                  Text('Last name', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  Container(height:48,
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
                      child:  TextFormField(
                          controller: lastName,
                          textInputAction: TextInputAction.next,
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
                            hintText: 'doe',
                          ))),
                  SizedBox(height: 15),

                  Text('Email', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  Container(height:48,
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
                      child:  TextFormField(
                      controller: email,
                          textInputAction: TextInputAction.next,
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
                        hintText: 'johndoe@gmail.com',
                      ))),
                  SizedBox(height: 15),
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
                          textInputAction: TextInputAction.next,
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
                        hintText: '*******',
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
                          textInputAction: TextInputAction.next,
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
                        hintText: '*******',
                      ))),
                  SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: TextButton(
                        child: Text("Sign up",
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
                  SizedBox(height: 20),


                ]))


        ));
  }

  void submitForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    } else {
      bool passValid = RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*").hasMatch(password.text);
      bool rpassValid = RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*").hasMatch(passwordAgain.text);

      String pattern =r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      RegExp regExp = RegExp(pattern);

      if(firstName.text.trim().isEmpty){
        this.showToast("Please enter first name");
      }
      else if(lastName.text.trim().isEmpty){
        this.showToast("Please enter last name");
      }
      else  if(email.text.trim().isEmpty){
        this.showToast("Please enter email address");
      }
      else if (!regExp.hasMatch(email.text ?? '')) {
        this.showToast("Please enter valid email address");
      }
      else if(password.text.trim().isEmpty){
        this.showToast("Please enter password");
      }
      else if(password.text.length < 8){
        this.showToast("Password must be at least 8 characters in length");
      }
      else if(!passValid){
        this.showToast("Password must contain 1 uppercase, 1 lowercase, 1 numeric number, 1 special character");
      }
      else if(passwordAgain.text.trim().isEmpty){
        this.showToast("Please enter password again");
      }
      else if(!rpassValid){
        this.showToast("Password again must contain 1 uppercase, 1 lowercase, 1 numeric number, 1 special character");
      }
      else if(passwordAgain.text.length < 8){
        this.showToast("Password again must be at least 8 characters in length");
      }
      else if(password.text != passwordAgain.text){
        this.showToast("Password again does not match the entered password");
      }
      else{
        setState(() {
          _isLoading = true;
        });
        registerUser();
      }

    }
  }

  void showToast(String msg)
  {
    Toast.show(msg, context);
    Timer(Duration(seconds: 3), () {
      Toast.dismiss();
    });
  }

  Future<void> registerUser() async {
    Map<String, String> data = {
      "first_name": firstName.text,
      "last_name": lastName.text,
      "email": email.text,
      "password": password.text,
      "password_confirmation": passwordAgain.text,
    };

    ApiService.registerUser(data).then((value) {
      setState(() {
        _isLoading = false;
      });
      if(value.success == true){
        this.showToast('Successfully Registered');
        setState(() {
          formKey.currentState?.reset();
          this.firstName.clear();
          this.lastName.clear();
          this.email.clear();
          this.password.clear();
          this.passwordAgain.clear();
          FocusScope.of(context).unfocus();
          Preference.setString("token", value.token ?? "");
          saveUserData(value!.user!);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
        });
      }
      else{
        this.showToast(value!.errors!);
      }
    });
  }
  Future<void> saveUserData(User user) async {
    Preference.setString("profileImg", user.profileImg ?? "");
    Preference.setString("name", user.firstName ?? "");
    Preference.setString("email", user.email ?? "");
  }
}
