import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/adinfo.dart';
import 'package:rent_app/contactinfo.dart';
import 'package:rent_app/models/CategoriesListBean.dart';
import 'package:rent_app/models/CityListBean.dart';
import 'package:rent_app/models/CountryListBean.dart';
import 'package:rent_app/models/StateListBean.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/propertyinfo.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/ProgressHUD.dart';
import 'package:rent_app/utils/kf_drawer.dart';
class TestPage extends KFDrawerContent{
  @override
  TestState createState() => TestState();
}
List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];

class TestState extends State<TestPage> {
  static int currentStep = 0;
  GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
  TextEditingController saleType = new TextEditingController();
  List<SaleType> saleTypeItems = [
    SaleType(1, "Buy"),
    SaleType(2, "Rent"),
    SaleType(2, "Lease"),
  ];
  List<DropdownMenuItem<SaleType>> saleTypeDropdownMenuItems = [];
  SaleType? selectedSaleTypeItem;
  bool _isLoading = false;
  List<Step> steps = [];
  @override
  void initState() {
    super.initState();
    saleTypeDropdownMenuItems = buildDropDownMenuItems(saleTypeItems);
    selectedSaleTypeItem = saleTypeDropdownMenuItems[0].value;
  }


  List<DropdownMenuItem<SaleType>> buildDropDownMenuItems(List<SaleType> saleTypeItems) {
    List<DropdownMenuItem<SaleType>> items = [];
    for (SaleType item in saleTypeItems) {
      items.add(
        DropdownMenuItem(
          child: Text(item.name),
          value: item,
        ),
      );
    }
    return items;
  }

  @override
  void dispose() {
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    steps = [Step(
        title: currentStep == 0 ? const Text('Ad Info', style: TextStyle(color:Colors.red,fontSize: 12, fontFamily: "Nunito-Bold")) :
        const Text('Ad Info', style: TextStyle(color:Colors.black54,fontSize: 12, fontFamily: "Nunito-Bold")),
        isActive: currentStep == 0 ? true : false,
        state:  StepState.indexed,
        content: AdInfoPage()),
      Step(
          title: currentStep == 1 ? const Text('Property Info', style: TextStyle(color:Colors.red,fontSize: 12, fontFamily: "Nunito-Bold")) :
          const Text('Property Info', style: TextStyle(color:Colors.black54,fontSize: 12, fontFamily: "Nunito-Bold")),
          isActive: currentStep == 1 ? true : false,
          state:  StepState.indexed,
          content: PropertyInfo()),
      Step(
          title: currentStep == 2 ? const Text('Contact Info', style: TextStyle(color:Colors.red,fontSize: 12, fontFamily: "Nunito-Bold")) :
          const Text('Contact Info', style: TextStyle(color:Colors.black54,fontSize: 12, fontFamily: "Nunito-Bold")),
          isActive: currentStep == 2 ? true : false,
          state:  StepState.indexed,
          content: ContactInfo())
    ];
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home :  Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: HexColor('FFFFFF'),
            body: ProgressHUD(
                inAsyncCall: _isLoading,
                opacity: 0.0,
                child: SafeArea(
              child:  Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 7, 20, 7),
                      child:  Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            child: Material(
                              shadowColor: Colors.transparent,
                              color: Colors.transparent,
                              // child: InkWell(onTap:() {
                              //   // setState(() {
                              //     widget.onMenuPressed;
                              //   // });
                              // },child : Image.asset(
                              //   "assets/menu_icon.png",
                              //   height: 60,
                              //   width: 60,
                              // )),

                              child: IconButton(
                                icon: Image.asset(
                                  "assets/menu_icon.png",
                                  height: 25,
                                  width: 24,),
                                onPressed: widget.onMenuPressed,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                        Container(height: 0),
                        Expanded(child:  contentWidget(size)),
                        Container(height: 0),
                      ]))
                ],
              ),

            ))

        ));
  }

  Widget footerWidget() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex:2,child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      5.0, 0, 5, 0),
                  child: SizedBox(
                      height: 48,
                      child: TextButton(
                        child: Text("Clear",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Nunito-Regular")),
                        style: TextButton.styleFrom(
                            primary: HexColor("F1635D"),
                            backgroundColor:
                            Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    48.0),
                                side: BorderSide(
                                    color: HexColor(
                                        "F1635D")))),
                        onPressed: () {
                          //submit();
                        },
                      )))),
              Expanded(flex:2,child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      5.0, 0, 5, 0),
                  child: SizedBox(
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
                          //submit();
                        },
                      )))),
            ]));
  }

  Widget contentWidget(Size size) {

    return  stepperWidget(size);

  }





  void showToast(String msg) {
    Toast.show(msg, context);
    Timer(Duration(seconds: 3), () {
      Toast.dismiss();
    });
  }

  Future<void> submitData() async {
    // Map<String, String> data =
    // // {
    // //   "title": AdInfoState.title.text,
    // //   "price": AdInfoState.price.text,
    // //   "description": AdInfoState.description.text,
    // //   "name": ContactInfoState.name.text,
    // //   "email":  ContactInfoState.email.text,
    // //   "phone": ContactInfoState.phone.text
    // // };
    //
    // {
    // "title":"yert22222",
    // "price":"10002",
    // "tags":"test, yrr",
    // "description":"serwerew",
    // "country_id":"1",
    // "state_id":"1",
    // "city_id":"1",
    // "str_address":"123 ree",
    // "pin_code":"123456",
    // "no_of_beds":"1",
    // "no_of_hall":"2",
    // "no_of_bathroom":"2",
    // "space":"11",
    // "year":"2020",
    // "no_floor":"2",
    // "name":"yert",
    // "email":"sss@gmail.com",
    // "phone":"9999999999",
    //   "amenities[]":"1"
    // };


    ApiService.postAd().then((value) {
      setState(() {
        _isLoading = false;
      });
      if(value!.success == true){
        this.showToast(value.message ?? '');
        setState(() {
          AdInfoState.title.clear();
          AdInfoState.price.clear();
         AdInfoState.description.clear();
          ContactInfoState.name.clear();
          ContactInfoState.email.clear();
          ContactInfoState.phone.clear();
          AdInfoState.imgPath1 = '';
          AdInfoState.imgPath2 = '';
          AdInfoState.imgPath3 = '';
          AdInfoState.tags.clear();
         AdInfoState.selectedCountry = null;
         AdInfoState.selectedState = null;
          AdInfoState.selectedCity = null;
         AdInfoState.streetAddress.clear();
          PropertyInfoState.selectedAmenitiesList!.clear();
          AdInfoState.pinCode.clear();
         PropertyInfoState.beds.clear();
         PropertyInfoState.hall.clear();
         PropertyInfoState.bathroom.clear();
         PropertyInfoState.space.clear();
         PropertyInfoState.builtYear.clear();
         PropertyInfoState.floors.clear();
         currentStep = 0;

        });
      }
      else{
        this.showToast(value.message ?? '');
      }
    });
  }

  Widget stepperWidget(Size size) {
    return Container(
        height: size.height,
        width: size.width,
        child:
        Stepper(
              controlsBuilder: (BuildContext? context,
                  {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Center(
                    child:Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        currentStep != 2 ? SizedBox(
                            width: 220,
                            height: 48,
                            child: TextButton(
                                child: Text("Continue",
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
                                onPressed: onStepContinue
                            )) : SizedBox(
                            width: 220,
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
                                  final isValid = ContactInfoState.formKey
                                      .currentState?.validate() ?? false;
                                  if (!isValid) {
                                    return;
                                  } else {
                                    if (ContactInfoState.name.text.isEmpty) {
                                      showToast("Name is required");
                                    }
                                    else
                                    if (ContactInfoState.email.text.isEmpty) {
                                      showToast("Email is required");
                                    }
                                    else
                                    if (ContactInfoState.phone.text.isEmpty) {
                                      showToast("Phone is required");
                                    }
                                    else {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      submitData();
                                    }
                                  }
                                })),

                      ],
                    )));
              },
              steps:  steps,
              physics: ClampingScrollPhysics(),
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepTapped: (step) {
                setState(() {
                  currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (currentStep < steps.length - 1) {
                    if (currentStep == 0) {
                      final isValid = AdInfoState.formKey.currentState?.validate() ?? false;
                      if (!isValid) {
                        return;
                      } else {
                        if (AdInfoState.title.text.isEmpty) {
                          showToast("Title is required");
                        }
                        else if (AdInfoState.price.text.isEmpty) {
                          showToast("Price is required");
                        }
                        else if (AdInfoState.description.text.isEmpty) {
                          showToast("Description is required");
                        }
                        else if (AdInfoState.selectedCategory==null) {
                          showToast("Category is required");
                        }
                        else if (AdInfoState.selectedCountry==null) {
                          showToast("Country is required");
                        }
                        else if (AdInfoState.selectedState==null) {
                          showToast("State is required");
                        }
                        else if (AdInfoState.selectedCity==null) {
                          showToast("City is required");
                        }
                        else if (AdInfoState.streetAddress==null) {
                          showToast("Street Address is required");
                        }
                        else if (AdInfoState.pinCode.text.isEmpty) {
                          showToast("PinCode is required");
                        }
                        else {
                          currentStep = currentStep + 1;
                        }
                      }
                    }
                    else if (currentStep == 1) {
                      final isValid = PropertyInfoState.formKey.currentState?.validate() ?? false;
                      if (!isValid) {
                        return;
                      } else {
                        if (PropertyInfoState.selectedAmenitiesList!.isEmpty) {
                          showToast("Please Select Amenities");
                        }
                        else {
                          currentStep = currentStep + 1;
                        }
                      }
                    }
                    else if (currentStep == 2) {
                      final isValid = ContactInfoState.formKey.currentState?.validate() ?? false;
                      if (!isValid) {
                        return;
                      } else {
                        if (ContactInfoState.name.text.isEmpty) {
                          showToast("Name is required");
                        }
                        else if (ContactInfoState.email.text.isEmpty) {
                          showToast("Email is required");
                        }
                        else if (ContactInfoState.phone.text.isEmpty) {
                          showToast("Phone is required");
                        }
                        else {
                          currentStep = currentStep + 1;
                        }
                      }
                    }
                  } else {
                    currentStep = 0;
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (currentStep > 0) {
                    currentStep = currentStep - 1;
                  } else {
                    currentStep = 0;
                  }
                });
              },
            ));
  }
}
class SaleType {
  int value;
  String name;
  SaleType(this.value, this.name);
}