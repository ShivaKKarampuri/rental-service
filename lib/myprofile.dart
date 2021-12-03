import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_app/homescreen.dart';
import 'package:rent_app/login.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/searchpage.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/ProgressHUD.dart';
import 'package:rent_app/utils/kf_drawer.dart';
import 'package:rent_app/utils/preferences.dart';

class MyProfilePage extends KFDrawerContent{
  @override
  MyProfilePageState createState() => MyProfilePageState();
}
class MyProfilePageState extends State<MyProfilePage> {
  bool _isHidden = true;
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController location = new TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? profileImg="", imageUrl="", provider="";
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getProfileDetails();
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
              title: Text("Edit", style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading:  IconButton(
                icon: Icon(Icons.chevron_left_outlined, size: 38),
                tooltip: 'Back Icon', color: HexColor('454555'),
                onPressed: () {
                  Preference.setString("name", firstName.text ?? ''+' '+lastName.text ?? '');
                  Preference.setString("email", email.text ?? '');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                },
              ),
              brightness: Brightness.dark,
            ),

            backgroundColor: HexColor('FFFFFF'),
            body: ProgressHUD(
              child:  Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                Container(height: 0),
                Expanded(child:  contentWidget()),
                Container(height: 0),
              ]),
              inAsyncCall: _isLoading,
              opacity: 0.0,
            )


        ));

  }



  Widget contentWidget() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: Form(key: formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      InkWell(onTap: (){
                        choosePhoto();
                        },
                          child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            provider == "google" || provider == "facebook" ?

                            Center(child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: HexColor('EEEEEF'),
                                    image: new DecorationImage(
                                      fit: profileImg!=null && profileImg!.isNotEmpty ? BoxFit.fill : BoxFit.none,
                                      // image: profileImg.isNotEmpty ?
                                      // new NetworkImage(profileImg) :
                                      // new AssetImage("assets/add_pic.png"),
                                      image:
                                      new NetworkImage(profileImg!)
                                    )
                                ))) :
                            Center(child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: HexColor('EEEEEF'),
                                    image: new DecorationImage(
                                      fit: profileImg!=null && profileImg!.isNotEmpty ? BoxFit.fill : BoxFit.none,
                                      // image: profileImg!=null && profileImg.isNotEmpty ?
                                      // new NetworkImage(
                                      //     imageUrl+"/"+profileImg) :
                                      // new AssetImage("assets/add_pic.png"),
                                      image: new NetworkImage(
                                          imageUrl!+"/"+profileImg!),
                                    )
                                ))),
                            SizedBox(height: 10),
                            Center(child: Text('Change Photo', style: TextStyle(fontSize: 14, fontFamily: "Nunito-Regular"))),
                          ]),),
                      SizedBox(height: 20),
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
                            readOnly: true,
                              controller: email,
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
                              ))),
                      SizedBox(height: 15),
                      Text('Phone', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                              controller: phone,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                              ))),
                      SizedBox(height: 15),
                      Text('Location', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                              controller: location,
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
                              ))),
                      SizedBox(height: 20),
                      SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: TextButton(
                            child: Text("Save",
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
      if(firstName.text.isEmpty){
        this.showToast("Please enter first name");
      }
      else if(lastName.text.isEmpty){
        this.showToast("Please enter last name");
      }
      else if(phone.text.isEmpty){
        this.showToast("Please enter phone number");
      }
      else if(phone.text.length !=10){
        this.showToast("Phone number must be of 10 digit");
      }
      else if(location.text.isEmpty){
        this.showToast("Please enter your location");
      }
      else{
        setState(() {
          _isLoading = true;
        });
        updateUser();
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

  Future<void> updateUser() async {
    Map<String, String> data = {
      "first_name": firstName.text,
      "last_name": lastName.text,
      "email": email.text,
      "phone": phone.text,
      "address": location.text,
      "city":'',
      "state":'',
      "country":'',
      "zip":''
    };

    ApiService.updateUser(data).then((value) {
      setState(() {
        _isLoading = false;
      });
      if(value.success == true){
        this.showToast(value.message ?? '');
        setState(() {
          formKey.currentState?.reset();
          FocusScope.of(context).unfocus();
          getProfileDetails();
        });
      }
      else{
        this.showToast(value.message ?? '');
      }
    });
  }

  void getProfileDetails() {
    ApiService.getProfileDetails().then((value) {
      setState(() {
        this.firstName.text = value.firstName ?? '';
        this.lastName.text = value.lastName ?? '';
        this.email.text = value.email ?? '';
        this.phone.text = value.phone ?? '';
        this.location.text = value.address ?? '';
        this.profileImg = value.profileImg ?? '';
        this.imageUrl = value.imageUrl ?? '';
        this.provider = value.provider ?? '';
      });
    });
  }

  Future choosePhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        setState(() {
          _isLoading = true;
        });
        ApiService.uploadPic(pickedFile.path).then((value) {
          setState(() {
            _isLoading = false;
            if(value.success == true){
              this.profileImg = value.user?.profileImg ?? '';
              this.imageUrl = value.imageUrl ?? '';
              this.showToast("Picture Uploaded Successfully!");
            }
            else{
              this.showToast("Picture Uploaded Failed!");
            }
          });
        });
      } else {
        print('No image selected.');
      }
  }
}
