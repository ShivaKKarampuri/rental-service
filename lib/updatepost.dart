import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/models/AdDetailsResponse.dart';
import 'package:rent_app/models/AmenitiesResponse.dart';
import 'package:rent_app/models/CityListBean.dart';
import 'package:rent_app/models/CountryListBean.dart';
import 'package:rent_app/models/StateListBean.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/updatecontactinfo.dart';
import 'package:rent_app/updatepropertyinfo.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/ProgressHUD.dart';
import 'updateadinfo.dart';
class UpdatePostPage extends StatefulWidget{
  String? id;
  UpdatePostPage({Key? key, this.id}) : super(key: key);
  @override
  UpdatePostState createState() => UpdatePostState();
}
List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];

class UpdatePostState extends State<UpdatePostPage> {
  var currentStep = 0;
  static var _focusNode =  FocusNode();
  GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
  TextEditingController saleType = new TextEditingController();
  List<SaleType> saleTypeItems = [
    SaleType(1, "Buy"),
    SaleType(2, "Rent"),
    SaleType(2, "Lease"),
  ];
  List<DropdownMenuItem<SaleType>> saleTypeDropdownMenuItems = [];
  SaleType? selectedSaleTypeItem;
  List<Step> steps = [];
  List<Countries> countryList = <Countries>[];
  Countries? selectedCountry;
  List<States> stateList = <States>[];
  States? selectedState;
  List<Cities> cityList = <Cities>[];
  Cities? selectedCity;
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
  static List<Amenities> selectedAmenitiesList = <Amenities>[];
  AdDetailsResponse? adDetailsResponse;
  @override
  void initState() {
    super.initState();
    UpdateAdInfoState.countryName = "";
    UpdateAdInfoState.stateName = "";
    UpdateAdInfoState.cityName = "";
    UpdateAdInfoState.uploadImgPath1 =  '';
    UpdateAdInfoState.uploadImgPath2 =  '';
    UpdateAdInfoState.uploadImgPath3 =  '';
    UpdateAdInfoState.selectedCategoryId = '';
    getAdDetails();
    saleTypeDropdownMenuItems = buildDropDownMenuItems(saleTypeItems);
    selectedSaleTypeItem = saleTypeDropdownMenuItems[0].value;
    // steps.add( Step(
    //     title: const Text('Ad Info', style: TextStyle(color:Colors.red,fontSize: 12, fontFamily: "Nunito-Bold")),
    //     isActive: currentStep == 0 ? true : false,
    //     state:  StepState.indexed,
    //     content: UpdateAdInfoPage()));
    // steps.add( Step(
    //     title: const Text('Property Info', style: TextStyle(color:Colors.red,fontSize: 12, fontFamily: "Nunito-Bold")),
    //     isActive: currentStep == 1 ? true : false,
    //     state:  StepState.indexed,
    //     content: UpdatePropertyInfo()));
    // steps.add( Step(
    //     title: const Text('Contact Info', style: TextStyle(color:Colors.red,fontSize: 12, fontFamily: "Nunito-Bold")),
    //     isActive: currentStep == 2 ? true : false,
    //     state:  StepState.indexed,
    //     content: UpdateContactInfo()));
    getCountryList();

  }
  void getAdDetails() {
    ApiService.getAdDetails(widget.id).then((value) {
      setState(() {
        adDetailsResponse = value;
        photo = value.ads!.photos;
        title = value.ads!.title;
        UpdateAdInfoState.title.text = title!;
        price = 'Rs.'+value.ads!.price.toString();
        UpdateAdInfoState.price.text = price!;
        tags = value.ads!.tags!=null ? value.ads!.tags : '';
        UpdateAdInfoState.tags.text = tags!;
        description = value.ads!.description;
        UpdateAdInfoState.description.text = description!;
        streetAddress =value.ads!.strAddress !=null ? value.ads!.strAddress : '';
        UpdateAdInfoState.streetAddress.text = streetAddress!;
        contactName = value.ads!.contactName;
        UpdateContactInfoState.name.text = contactName!;
        contactEmail = value.ads!.contactEmail;
        UpdateContactInfoState.email.text = contactEmail!;
        contactPhone = value.ads!.contactPhone;
        UpdateContactInfoState.phone.text = contactPhone!;
        pinCode = value.ads!.pincode!=null ? value.ads!.pincode : '';
        UpdateAdInfoState.pinCode.text = pinCode!;
        UpdateAdInfoState.uploadImgPath1 = value.ads!.photos ?? '';
        UpdateAdInfoState.uploadImgPath2 = value.ads!.photos1 ?? '';
        UpdateAdInfoState.uploadImgPath3 = value.ads!.photos2 ?? '';
        if(value.ads!.category!=null){
          UpdateAdInfoState.selectedCategoryId = value.ads!.category.toString();
        }
        beds = value.ads!.beds!=null ? value.ads!.beds.toString() : '';
        UpdatePropertyInfoState.beds.text = beds!;
        halls  = value.ads!.halls!=null ? value.ads!.halls.toString() : '';
        UpdatePropertyInfoState.hall.text = halls!;
        bathrooms = value.ads!.bathroom!=null ? value.ads!.bathroom.toString() : '';
        UpdatePropertyInfoState.bathroom.text = bathrooms!;
        space = value.ads!.space!=null ? value.ads!.space : '';
        UpdatePropertyInfoState.space.text = space!;
        year = value.ads!.year!=null ? value.ads!.year.toString() : '';
        UpdatePropertyInfoState.builtYear.text = year!;
        floors = value.ads!.floors!=null ? value.ads!.floors.toString() : '';
        UpdatePropertyInfoState.floors.text = floors!;
        if( value.ads!.countrydata !=null){
          UpdateAdInfoState.ccountryName.text= value.ads!.countrydata!.name ?? '';
        }
        if( value.ads!.statedata !=null){
          UpdateAdInfoState.cstateName.text = value.ads!.statedata!.name ?? '';
        }
        if( value.ads!.citydata !=null){
          UpdateAdInfoState.ccityName.text = value.ads!.citydata!.name ?? '';
        }
        if(value.ads!.amenities !=null){
          for(int i=0; i< value.ads!.amenities!.length ; i++){
            selectedAmenitiesList.add(Amenities(id: value.ads!.amenities![i].id, title: value.ads!.amenities![i].title));
          }
          selectedAmenitiesList = value.ads!.amenities ?? [];
        }

        //    countryData = value.ads!.countrydata ?? null;
     //   stateData = value.ads!.statedata ?? null;
    //    cityData = value.ads!.citydata ?? null;
     // //   Countries countries = new Countries(id: countryData!.id, name: countryData!.name);
     //    this.countryList.forEach((element) {
     //      if (element.name == countryData!.name) {
     //        UpdateAdInfoState.selectedCountry = element;
     //      }
     //    });
      });
    });

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
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  steps = [Step(
        title: currentStep == 0 ? const Text('Ad Info', style: TextStyle(color:Colors.red,fontSize: 12, fontFamily: "Nunito-Bold")) :
        const Text('Ad Info', style: TextStyle(color:Colors.black54,fontSize: 12, fontFamily: "Nunito-Bold")),
        isActive: currentStep == 0 ? true : false,
        state:  StepState.indexed,
        content: UpdateAdInfoPage()),
    Step(
    title: currentStep == 1 ? const Text('Property Info', style: TextStyle(color:Colors.red,fontSize: 12, fontFamily: "Nunito-Bold")) :
    const Text('Property Info', style: TextStyle(color:Colors.black54,fontSize: 12, fontFamily: "Nunito-Bold")),
    isActive: currentStep == 1 ? true : false,
    state:  StepState.indexed,
    content: UpdatePropertyInfo()),
    Step(
    title: currentStep == 2 ? const Text('Contact Info', style: TextStyle(color:Colors.red,fontSize: 12, fontFamily: "Nunito-Bold")) :
    const Text('Contact Info', style: TextStyle(color:Colors.black54,fontSize: 12, fontFamily: "Nunito-Bold")),
    isActive: currentStep == 2 ? true : false,
    state:  StepState.indexed,
    content: UpdateContactInfo())];
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home :  Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: HexColor('FFFFFF'),
            appBar: AppBar(
                automaticallyImplyLeading: true,
                title: Text('Update Post'),
                leading: IconButton(icon:Icon(Icons.arrow_back), color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
            ),
            body: ProgressHUD(
                inAsyncCall: _isLoading,
                opacity: 0.0,
                child: SafeArea(
                  child:  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: <Widget>[
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

  void getCountryList() {
    ApiService.getCountryList().then((value) {
      setState(() {
        countryList = value.countries ?? [];
      });
    });
  }

  //Sale type dropdown widget
  Widget saleTypeDropDownWidget() {
    return DropdownButtonFormField<SaleType>(
      isExpanded: true,
      decoration: InputDecoration(
          hintText: 'Select',
          border: OutlineInputBorder(),
          contentPadding:
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
      items: saleTypeItems
          .map((label) => DropdownMenuItem(
        child: new Text(
          label.name,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
        ),
        value: label,
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedSaleTypeItem = value;
          //    formKey.currentState?.validate();
        });
      },
    );
  }

  //Country dropdown widget
  Widget countryDropDownWidget() {
    return DropdownButtonFormField<Countries>(
      isExpanded: true,
      decoration: InputDecoration(
          hintText: 'Select',
          border: OutlineInputBorder(),
          contentPadding:
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
      items: countryList
          .map((label) => DropdownMenuItem(
        child: new Text(
          label.name ?? '',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
        ),
        value: label,
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCountry = value;
          getStatesList(selectedCountry!.id!);
        });
      },
    );
  }

  void getStatesList(int id) {
    ApiService.getStateList(id).then((value) {
      setState(() {
        stateList = value.states ?? [];
      });
    });
  }

  //State dropdown widget
  Widget stateDropDownWidget() {
    return selectedCountry!=null ?
    DropdownButtonFormField<States>(
      isExpanded: true,
      decoration: InputDecoration(
          hintText: 'Select',
          border: OutlineInputBorder(),
          contentPadding:
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
      items: stateList
          .map((label) => DropdownMenuItem(
        child: new Text(
          label.name ?? '',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
        ),
        value: label,
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedState = value;
          getCitiesList(selectedState!.id!);
        });
      },
    ) : TextFormField(
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'State',
          contentPadding:
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ));
  }

  void getCitiesList(int id) {
    ApiService.getCityList(id).then((value) {
      setState(() {
        cityList = value.cities ?? [];
      });
    });
  }

  //City dropdown widget
  Widget cityDropDownWidget() {
    return selectedState!=null ?
    DropdownButtonFormField<Cities>(
      isExpanded: true,
      decoration: InputDecoration(
          hintText: 'Select',
          border: OutlineInputBorder(),
          contentPadding:
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
      items: cityList
          .map((label) => DropdownMenuItem(
        child: new Text(
          label!.name!,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
        ),
        value: label,
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCity = value;
        });
      },
    ) : TextFormField(
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'City',
          contentPadding:
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ));
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
    // //   "title": UpdateAdInfoState.title.text,
    // //   "price": UpdateAdInfoState.price.text,
    // //   "description": UpdateAdInfoState.description.text,
    // //   "name": UpdateContactInfoState.name.text,
    // //   "email":  UpdateContactInfoState.email.text,
    // //   "phone": UpdateContactInfoState.phone.text
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


    ApiService.updateAd(widget.id).then((value) {
      setState(() {
        _isLoading = false;
      });
      if(value!.success == true){
        this.showToast(value.message ?? '');
        setState(() {
          UpdateAdInfoState.title.clear();
          UpdateAdInfoState.price.clear();
          UpdateAdInfoState.description.clear();
          UpdateContactInfoState.name.clear();
          UpdateContactInfoState.email.clear();
          UpdateContactInfoState.phone.clear();
          UpdateAdInfoState.imgPath1 = '';
          UpdateAdInfoState.imgPath2 = '';
          UpdateAdInfoState.imgPath3 = '';
          UpdateAdInfoState.tags.clear();
          UpdateAdInfoState.selectedCountry = null;
          UpdateAdInfoState.selectedState = null;
          UpdateAdInfoState.selectedCity = null;
          UpdateAdInfoState.selectedCategory = null;
          UpdateAdInfoState.selectedCategoryId = '';
          UpdateAdInfoState.streetAddress.clear();
          UpdateAdInfoState.pinCode.clear();
          UpdatePropertyInfoState.beds.clear();
          UpdatePropertyInfoState.hall.clear();
          UpdatePropertyInfoState.bathroom.clear();
          UpdatePropertyInfoState.space.clear();
          UpdatePropertyInfoState.builtYear.clear();
          UpdatePropertyInfoState.floors.clear();
          currentStep = 0;

          Navigator.pop(context, 'OK');

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
                                  final isValid = UpdateContactInfoState.formKey
                                      .currentState?.validate() ?? false;
                                  if (!isValid) {
                                    return;
                                  } else {
                                    if (UpdateContactInfoState.name.text.isEmpty) {
                                      showToast("Name is required");
                                    }
                                    else
                                    if (UpdateContactInfoState.email.text.isEmpty) {
                                      showToast("Email is required");
                                    }
                                    else
                                    if (UpdateContactInfoState.phone.text.isEmpty) {
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
          steps: steps,
          physics: ClampingScrollPhysics(),
          type: StepperType.horizontal,
          currentStep: this.currentStep,
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (currentStep < steps.length - 1) {
                if (currentStep == 0) {
                  final isValid = UpdateAdInfoState.formKey.currentState?.validate() ?? false;
                  if (!isValid) {
                    return;
                  } else {
                    if (UpdateAdInfoState.title.text.isEmpty) {
                      showToast("Title is required");
                    }
                    else if (UpdateAdInfoState.price.text.isEmpty) {
                      showToast("Price is required");
                    }
                    else if (UpdateAdInfoState.description.text.isEmpty) {
                      showToast("Description is required");
                    }
                    else {
                      currentStep = currentStep + 1;
                    }
                  }
                }
                else if (currentStep == 1) {
                  currentStep = currentStep + 1;
                }
                else if (currentStep == 2) {
                  final isValid = UpdateContactInfoState.formKey.currentState?.validate() ?? false;
                  if (!isValid) {
                    return;
                  } else {
                    if (UpdateContactInfoState.name.text.isEmpty) {
                      showToast("Name is required");
                    }
                    else if (UpdateContactInfoState.email.text.isEmpty) {
                      showToast("Email is required");
                    }
                    else if (UpdateContactInfoState.phone.text.isEmpty) {
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