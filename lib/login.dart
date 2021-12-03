import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/forgotpassword.dart';
import 'package:rent_app/homescreen.dart';
import 'package:rent_app/models/RegisterUserResponse.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/register.dart';
import 'package:rent_app/searchpage.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/ProgressHUD.dart';
import 'package:rent_app/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  TextEditingController email = new TextEditingController();
  TextEditingController forgotUsername = new TextEditingController();
  TextEditingController password = new TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  GoogleSignInAccount? googleLoginObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  Map fbLoginObj = {};
  @override
  void initState() {
    super.initState();
    email.text = 'asd@gmail.com';
    password.text = 'Pass@word1';
    // email.text = 'santhumittapally@gmail.com';
    // password.text = 'Santhu@123';
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
              Expanded(child: contentWidget()),
              Container(height: 60,color: Colors.transparent, child: footerWidget()),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      } ,
                  child : Text("New user?",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Nunito-Regular"))))),
              Center(child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      5.0, 0, 5, 0),
                  child:InkWell(
    onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
    } ,
                 child: Text("Sign up",
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
           child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Center(child: Image.asset(
                    "assets/applogo.png",
                    height: 60,
                    width: 60,
                  )),
                  SizedBox(height: 30),
                  Center(child:Text('Welcome!',textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontFamily: "Nunito-Bold"))),
                  SizedBox(height: 10),
                  Center(child:Text('Sign in or register to save your favorite homes', textAlign: TextAlign.center,style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular"))),
                  SizedBox(height: 20,),
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
                          )
                     )),
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
                  Container(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color:HexColor('888892'),fontSize: 16, fontFamily: "Nunito-Regular"),
                          ),
                          onTap: () {

                            if(email.text.isEmpty){
                              this.showToast('Please enter email/phone');
                            }
                            else{
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage(email: email.text)));
                            }

                          }),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                      height: 48,
                      child: TextButton(
                        child: Text("Login",
                            style: TextStyle(
                                fontSize: 16, fontFamily: "Nunito-Regular")),
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
                                        "FFFFFF")))),
                        onPressed: () {
                          submitForm();
                        },
                      )),
                  SizedBox(height: 20),
                  Row(crossAxisAlignment:CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 3, child :Divider( height: 40,
                        thickness: 2,)),
                      Expanded(flex:2,child: Text("OR",textAlign: TextAlign.center,
                          style: TextStyle(
                            color: HexColor('454555'),
                              fontSize: 16,
                              fontFamily: "Nunito-Regular"))),
                      Expanded(flex:3,child: Divider( height: 40,
                        thickness: 2,)),
                    ],),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(flex:2,child: Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 0, 5, 0),
                            child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:BorderRadius.circular(
                                      48.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  child: Center(child: Image.asset(
                                    "assets/google.png"
                                  )),
                                  style: TextButton.styleFrom(
                                      primary: HexColor("FFFFFF"),
                                      backgroundColor:
                                      Colors.white,
                                      shadowColor: HexColor("979797"),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              48.0),
                                          side: BorderSide(
                                              color: HexColor(
                                                  "FFFFFF")))),
                                  onPressed: () {
                                    _googleSignIn.signIn().then((userData) {
                                      setState(() {
                                        googleLoginObj = userData;
                                        _isLoading = true;
                                        googleLogin(googleLoginObj!);
                                      });
                                    });
                                    //     .catchError((e) {
                                    //   this.showToast(e.toString());
                                    //  // print(e);
                                    // });
                                  },
                                )))),
                        Expanded(flex:2,child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                5.0, 0, 5, 0),
                            child: SizedBox(
                                height: 48,
                                child: TextButton(
                                  child: Center(child: Image.asset(
                                      "assets/facebook.png"
                                  )),
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor:
                                      HexColor("5D65F1"),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              48.0),
                                          side: BorderSide(
                                              color: HexColor(
                                                  "5D65F1")))),
                                  onPressed: () {
                                    FacebookAuth.instance.login(
                                        permissions: ["public_profile", "email"]).then((value) {
                                      FacebookAuth.instance.getUserData().then((userData) {
                                        setState(() {
                                          _isLoading = true;
                                          fbLoginObj = userData;
                                          facebookLogin(fbLoginObj);
                                        });
                                      })
                                          .catchError((e) {
                                       // this.showToast(e.toString());
                                        // print(e);
                                      });
                                    });
                                    },
                                )))),
                      ]),
                  SizedBox(height: 20),
                ]))

        ));
  }

  void submitForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    bool passValid = RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*").hasMatch(password.text);
    if (!isValid) {
      return;
    } else {
      String pattern =  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      RegExp regExp = RegExp(pattern);

      if(email.text.trim().isEmpty){
        this.showToast("Please enter email address");
      }
      else if (!regExp.hasMatch(email.text ?? '')) {
        this.showToast("Please enter valid email address");
      }
      else if(password.text.trim().isEmpty){
        this.showToast("Please enter password");
      }
      else if(!passValid){
        this.showToast("Password must contain 1 uppercase, 1 lowercase, 1 numeric number, 1 special character");
      }
      else{
        setState(() {
          _isLoading = true;
        });
        loginUser();
      }

    }
  }
  Future<void> loginUser() async {
    Map<String, String> data = {
      "email": email.text,
      "password": password.text,
    };

    ApiService.loginUser(data).then((value) {
      setState(() {
        _isLoading = false;
      });
      if(value.success == true){
        this.showToast('Login Successful!');
        setState(() {
          formKey.currentState?.reset();
          this.email.clear();
          this.password.clear();
          FocusScope.of(context).unfocus();
          Preference.setString("provider", "login");
          Preference.setString("token", value.token ?? "");
          saveUserData(value!.user!);
          SchedulerBinding.instance!.addPostFrameCallback((_) {

            // add your code here.

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));

          });

        });
      }
      else{
        this.showToast(value.errors ?? '');
      }

    });
  }

  void showToast(String msg)
  {
    Toast.show(msg, context);
    Timer(Duration(seconds: 3), () {
      Toast.dismiss();
    });
  }

 Future<void> googleLogin(GoogleSignInAccount gLoginObj) async {
   Map<String, String> data = {
     "name": gLoginObj.displayName ?? '',
     "email": gLoginObj.email,
     "avatar": gLoginObj.photoUrl ?? '',
     "provider": "google",
     "provider_id": googleLoginObj!.id ?? '',

   };
   String provider = "google";

   ApiService.socialLoginUser(data, provider).then((value) {
     setState(() {
       _isLoading = false;
     });
     if(value?.user!=null){
       if(value.success == true){
         this.showToast('Login Successful!');
         setState(() {
           formKey.currentState?.reset();
           this.email.clear();
           this.password.clear();
           FocusScope.of(context).unfocus();
           Preference.setString("avatar", gLoginObj.photoUrl ?? '');
           Preference.setString("provider", "google");
           Preference.setString("token", value.token ?? "");
           saveUserData(value!.user!);
           Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
         });
       }
       else{
         this.showToast(value.errors ?? '');
       }
     }
     else{
       this.showToast('something went wrong');
     }
   });
  }

  Future<void> facebookLogin(Map fbLoginObj) async {
    Map<String, String> data = {
      "name": fbLoginObj["name"],
      "email": fbLoginObj["email"],
      "avatar": fbLoginObj["picture"]["data"]["url"],
      "provider": "facebook",
      "provider_id": fbLoginObj["id"],

    };
    String provider = "facebook";

    ApiService.socialLoginUser(data, provider).then((value) {
      setState(() {
        _isLoading = false;
      });
      if(value?.user!=null) {
        if (value.success == true) {
          this.showToast('Login Successful!');
          setState(() {
            formKey.currentState?.reset();
            this.email.clear();
            this.password.clear();
            FocusScope.of(context).unfocus();
            Preference.setString("avatar", fbLoginObj["picture"]["data"]["url"]);
            Preference.setString("provider", "facebook");
            saveUserData(value!.user!);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          });
        }
        else {
          this.showToast(value!.errors!);
        }
      }
      else{
        this.showToast('something went wrong');
      }
    });
  }

  Future<void> saveUserData(User user) async {
    Preference.setString("profileImg", user.profileImg ?? "");
    Preference.setString("name", user.firstName ?? "");
    Preference.setString("email", user.email ?? "");
    Preference.setString("userId", user!.id!.toString());
    Preference.setString("imgUrl", 'http://classified.ecodelinfotel.com/public/img/profile_imgs/');
  }
}
