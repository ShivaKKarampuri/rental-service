import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/adinfo.dart';
import 'package:rent_app/contactinfo.dart';
import 'package:rent_app/models/AdDetailsResponse.dart';
import 'package:rent_app/models/CityListBean.dart';
import 'package:rent_app/models/CountryListBean.dart';
import 'package:rent_app/models/StateListBean.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/propertyinfo.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/ProgressHUD.dart';
import 'package:rent_app/utils/kf_drawer.dart';
import 'package:rent_app/utils/preferences.dart';
class AdDetailsPage extends StatefulWidget{
  String? id;
  AdDetailsPage({Key? key, this.id}) : super(key: key);
  @override
  AdDetailsState createState() => AdDetailsState();
}

class AdDetailsState extends State<AdDetailsPage> {
  bool _isLoading = false;
  String? photo = "";
  String? title = "";
  String? price = "";
  String? tags = "";
  String? description = "";
  String? streetAddress = "";
  String? type = "";
  String? contactName = "";
  String? contactEmail = "";
  String? contactPhone = "";
  String? pinCode = "";
  String? beds = "";
  String? halls = "";
  String? bathrooms = "";
  String? space = "";
  String? year = "";
  String? floors = "";
  Countrydata? countryData;
  Countrydata? stateData;
  Countrydata? cityData;
  String? amenities = "";
  var messageForm = GlobalKey<FormState>();
TextEditingController messageController= new TextEditingController();
  bool autovalidate = false;
  String postedUserId = "";

  @override
  void initState() {
    super.initState();
    getAdDetails();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: HexColor('FFFFFF'),
            body: ProgressHUD(
                inAsyncCall: _isLoading,
                opacity: 0.0,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(height: 0),
                                Expanded(child: contentWidget()),
                                Container(height: 0),
                              ]))
                    ],
                  ),

                ))

        ));
  }
  Widget contentWidget(){
    return SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                photo !="" ?
                Image.network(
                    'http://classified.ecodelinfotel.com/public/img/cmspage/'+photo!,
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    fit:BoxFit.cover): Image.asset('assets/sample1.jpeg', width: MediaQuery.of(context).size.width,
                  fit:BoxFit.cover, height: 250,),
                Container( width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      shape:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      elevation: 8,
                      child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(price!, style: TextStyle(fontSize: 18,color: Colors.red, fontFamily: "Nunito-Bold")),
                              SizedBox(height: 10),
                              Text(title!, style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                              SizedBox(height: 10),
                              Text(description!, style: TextStyle(fontSize: 14, fontFamily: "Nunito-Regular")),
                              SizedBox(height: 10),
                              Divider(
                                height: 1,
                                thickness: 1.0,
                                color: HexColor("C4C4C4"),
                              ),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on_rounded),SizedBox(width: 10,),
                                    Text('Address', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold"))
                                  ]),
                              SizedBox(height: 10),
                              Text(streetAddress!, style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular")),
                              SizedBox(height: 10),
                              Divider(
                                height: 1,
                                thickness: 1.0,
                                color: HexColor("C4C4C4"),
                              ),
                              SizedBox(height: 10),
                              Row(children: [
                                Expanded(child: Row(mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.king_bed_rounded),
                                    SizedBox(width: 10,),
                                    Column(children: [
                                      Text('No.of Beds', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular")),
                                      Text(beds!, style: TextStyle(fontSize: 16, color:Colors.red, fontFamily: "Nunito-Bold"))
                                    ],)
                                  ],)),
                                Expanded(child: Row(mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.meeting_room_rounded),
                                    SizedBox(width: 10,),
                                    Column(children: [
                                      Text('No.of Halls', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular")),
                                      Text(halls!, style: TextStyle(fontSize: 16, color:Colors.red, fontFamily: "Nunito-Bold"))
                                    ],)
                                  ],)),
                              ],),
                              SizedBox(height: 20),
                              Row(children: [
                                Expanded(child: Row(mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.bathtub_rounded),
                                    SizedBox(width: 10,),
                                    Column(children: [
                                      Text('No.of Bathrooms', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular")),
                                      Text(bathrooms!, style: TextStyle(fontSize: 16, color:Colors.red, fontFamily: "Nunito-Bold"))
                                    ],)
                                  ],)),
                                Expanded(child: Row(mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.widgets_rounded),
                                    SizedBox(width: 10,),
                                    Column(children: [
                                      Text('No.of Floors', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular")),
                                      Text(floors!, style: TextStyle(fontSize: 16, color:Colors.red, fontFamily: "Nunito-Bold"))
                                    ],)
                                  ],)),
                              ],),
                              SizedBox(height: 10),
                              Divider(
                                height: 1,
                                thickness: 1.0,
                                color: HexColor("C4C4C4"),
                              ),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.map),SizedBox(width: 10,),
                                    Text('Space', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold"))
                                  ]),
                              SizedBox(height: 10),
                              Text(space!, style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular")),
                              SizedBox(height: 10),
                              Divider(
                                height: 1,
                                thickness: 1.0,
                                color: HexColor("C4C4C4"),
                              ),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.list),
                                    Text('Amenities', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold"))
                                  ]),
                              SizedBox(height: 10),
                              Text(amenities!, style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular")),
                              SizedBox(height: 10),
                              Divider(
                                height: 1,
                                thickness: 1.0,
                                color: HexColor("C4C4C4"),
                              ),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.tag),
                                    Text('Tags', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold"))
                                  ]),
                              SizedBox(height: 10),
                              Text(tags!, style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular")),
//contact details
                              SizedBox(height: 10),
                              Divider(
                                height: 1,
                                thickness: 1.0,
                                color: HexColor("C4C4C4"),
                              ),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.account_circle),
                                    Text('Contact Details', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold"))
                                  ]),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.account_circle, size: 48,),
                                SizedBox(width: 15),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(contactName!, style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                                    SizedBox(height: 4,),
                                    Text(contactEmail!, style: TextStyle(fontSize: 13, fontFamily: "Nunito-Regular"))
                                  ],
                                )

                              ]),
                              SizedBox(height: 10),
                              Container(
                                  width: double.infinity,
                                  height: 48,
                                  child: TextButton(
                                    child: Text("Send Message",
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
                                      showMessageDialog();
                                    },
                                  )),
                            ],)
                      ),
                    ))

              ],),
            Align(alignment:Alignment.topLeft,
                child: IconButton(
              icon: Icon(Icons.chevron_left_outlined, size: 38),
              tooltip: 'Back Icon', color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ))
            ]));
  }

  void showToast(String msg) {
    Toast.show(msg, context);
    Timer(Duration(seconds: 3), () {
      Toast.dismiss();
    });
  }

  void getAdDetails() {
    ApiService.getAdDetails(widget.id).then((value) {
      setState(() {
        photo = value.ads!.photos;
        title = value.ads!.title;
        price = 'Rs.'+value.ads!.price.toString();
        tags = value.ads!.tags!=null ? value.ads!.tags : '';
        description = value.ads!.description;
        streetAddress =value.ads!.strAddress !=null ? value.ads!.strAddress : '';
        title = value.ads!.title;
        contactName = value.ads!.contactName;
        contactEmail = value.ads!.contactEmail;
        contactPhone = value.ads!.contactPhone;
        pinCode = value.ads!.pincode;
        beds = value.ads!.beds!=null ? value.ads!.beds.toString() : '';
        halls  = value.ads!.halls!=null ? value.ads!.halls.toString() : '';
        bathrooms = value.ads!.bathroom!=null ? value.ads!.bathroom.toString() : '';
        space = value.ads!.space!=null ? value.ads!.space : '';
        year = value.ads!.year!=null ? value.ads!.year.toString() : '';
        floors = value.ads!.floors!=null ? value.ads!.floors.toString() : '';
        countryData = value.ads!.countrydata ?? null;
        postedUserId = value.ads!.userId.toString();

        // stateData = value.ads!.statedata ?? null;
       // cityData = value.ads!.citydata ?? null;
      //  amenities = value.ads!.amenities;

      });
    });

  }

  void showMessageDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Form(
            key: messageForm,
            // ignore: deprecated_member_use
            autovalidate: autovalidate,
            child: AlertDialog(
              title: new Text("Send Message",
                  style: TextStyle(
                      fontSize: 20, //fontWeight: FontWeight.bold
                      color: HexColor("1898d5"))),
              content: TextFormField(
                controller: messageController,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'please enter message';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(hintText: 'Enter the message'),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    messageController.text = "";
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    final isValid = messageForm.currentState?.validate();
                    if (isValid == false) {
                      setState(() => autovalidate = true);
                      return;
                    } else {
                      sendMessage(messageController.text);
                      messageController.text = "";
                      Navigator.pop(context, 'OK');
                    }
                  },
                  child: const Text('Send'),
                ),
              ],
            ));
      },
    );
  }

  Future<void> sendMessage(String text) async{
    Map<String, String> data = {
      "conversion_id":"",
      "sender_id": Preference?.getInt("userId").toString(),
      "sender_name": Preference?.getString("name") ?? '',
      "message":  text,
      "ad_id": widget!.id!,
      "receiver_id": postedUserId
    };
    print(data);

    ApiService.sendMessage(data).then((value) {
      setState(() {
        _isLoading = false;
      });

    });
  }
}