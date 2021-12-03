import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_app/models/AdDetailsResponse.dart';
import 'package:rent_app/models/CategoriesListBean.dart';
import 'package:rent_app/models/CityListBean.dart';
import 'package:rent_app/models/CountryListBean.dart';
import 'package:rent_app/models/StateListBean.dart';
import 'package:rent_app/network/ApiService.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
class UpdateAdInfoPage extends StatefulWidget {
//  UpdateAdInfoPage({Key? key, this.details}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UpdateAdInfoState();
  }
}

class UpdateAdInfoState extends State<UpdateAdInfoPage> {
  static final formKey = GlobalKey<FormState>();
  static TextEditingController title = new TextEditingController();
  static TextEditingController price = new TextEditingController();
  static TextEditingController tags = new TextEditingController();
  static TextEditingController description = new TextEditingController();
  static TextEditingController streetAddress = new TextEditingController();
  static TextEditingController pinCode = new TextEditingController();
  static String imgPath1 ="", imgPath2 ="", imgPath3 ="";
  static String uploadImgPath1 ="", uploadImgPath2 ="", uploadImgPath3 ="";

  static TextEditingController ccountryName = new TextEditingController();
  static TextEditingController cstateName = new TextEditingController();
  static TextEditingController ccityName = new TextEditingController();

  TextEditingController saleType = new TextEditingController();
  List<SaleType> saleTypeItems = [
    SaleType(1, "Buy"),
    SaleType(2, "Rent"),
    SaleType(2, "Lease"),
  ];
  List<DropdownMenuItem<SaleType>> saleTypeDropdownMenuItems = [];
  SaleType? selectedSaleTypeItem;
  List<Step> steps = [];
  static List<Countries> countryList = <Countries>[];
  static Countries? selectedCountry;
  List<States> stateList = <States>[];
  static States? selectedState;
  List<Cities> cityList = <Cities>[];
  static Cities? selectedCity;
  final picker = ImagePicker();
  static String countryName = "";

  static String stateName = "";

  static String cityName = "";

  List<Categories>? categoriesList = <Categories>[];
  static Categories? selectedCategory;
  static String selectedCategoryId = UpdateAdInfoState.selectedCategoryId;
  @override
  void initState() {
    super.initState();
    getCategoriesList();

  }
  void getCategoriesList() {
    categoriesList?.clear();
    ApiService.getCategoriesList().then((value) {
      setState(() {
        categoriesList = value.categories ?? [];
        if(selectedCategoryId!=""){
          var category = this.categoriesList!.firstWhere((e) => e.id ==  int.parse(selectedCategoryId));
          selectedCategory = category;
        }
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(child:
    Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Container(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Category', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                      child:  categoryDropDownWidget()),
                  SizedBox(height: 15),
                  Text('Title \*', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                          controller: title,
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
                          ))),
                  SizedBox(height: 15),
                  Text('Price \*', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                          controller: price,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                          ))),
                  SizedBox(height: 15),
                  Text('Tags', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                          controller: tags,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: '(Separate with commas)',
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
                  Text('Description \*', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  Container(height:100,
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
                          controller: description,
                          keyboardType:
                          TextInputType.multiline,
                          textInputAction:
                          TextInputAction.newline,
                          minLines: 6,
                          maxLines: 50,
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
                  Text('Photos', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  Row(crossAxisAlignment:CrossAxisAlignment.start, children: [
                        uploadImgPath1.isNotEmpty || imgPath1.isNotEmpty ?
                        InkWell(onTap: (){
                          choosePhoto1();
                        },
                        child: Container(height:110,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:BorderRadius.circular(
                                      4.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child:  Center(child: imgPath1.isNotEmpty ? Image.file(File(imgPath1)) : Image.network(
                                    'http://classified.ecodelinfotel.com/public/img/cmspage/'+uploadImgPath1))))
                            :
                        InkWell(onTap: (){
                          choosePhoto1();
                        },child:Container(height:110,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
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
                child:  Center(child: Icon(Icons.add, size: 24)))),
                       SizedBox(width: 10,),
                    uploadImgPath2.isNotEmpty  || imgPath2.isNotEmpty?
                    InkWell(onTap: (){
                      choosePhoto2();
                    },
                        child: Container(height:110,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:BorderRadius.circular(
                                  4.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child:  Center(child: imgPath2.isNotEmpty  ? Image.file(File(imgPath2)) : Image.network(
                                'http://classified.ecodelinfotel.com/public/img/cmspage/'+uploadImgPath2))))
                        :
                    InkWell(onTap: (){
                      choosePhoto2();
                    },child:Container(height:110,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
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
                        child:  Center(child: Icon(Icons.add, size: 24)))),
                    SizedBox(width: 10,),

                    uploadImgPath3.isNotEmpty  || imgPath3.isNotEmpty ?
                    InkWell(onTap: (){
                      choosePhoto3();
                    },
                        child: Container(height:110,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:BorderRadius.circular(
                                  4.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(child: imgPath3.isNotEmpty  ? Image.file(File(imgPath3)) : Image.network(
                                'http://classified.ecodelinfotel.com/public/img/cmspage/'+uploadImgPath3))))
                        :
                    InkWell(onTap: (){
                      choosePhoto3();
                    },child:Container(height:110,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
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
                        child:  Center(child: Icon(Icons.add, size: 24)))),
                    SizedBox(width: 10,),
                  ],),
                  SizedBox(height: 15),
                  Text('Street Address', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  Container(height:100,
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
                          controller: streetAddress,
                          keyboardType:
                          TextInputType.multiline,
                          textInputAction:
                          TextInputAction.newline,
                          minLines: 3,
                          maxLines: 5,
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
                  Text('Country', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                          controller: ccountryName,
                          enabled: false,
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
                          ))),
                  SizedBox(height: 15),
                  Text('State', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                      child:   TextFormField(
                          controller: cstateName,
                          enabled: false,
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
                          ))),
                  SizedBox(height: 15),
                  Text('City', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                      child:   TextFormField(
                          controller: ccityName,
                          enabled: false,
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
                          ))),
                  SizedBox(height: 15),
                  Text('Pin Code', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                          controller: pinCode,
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
                ],
              ),
            ))));
  }

  void getCountryList() {
    ApiService.getCountryList().then((value) {
      setState(() {
        countryList = value.countries ?? [];
      });
    });
  }

  //Category dropdown widget
  Widget categoryDropDownWidget() {
    if(selectedCategoryId!=""){
      return DropdownButtonFormField<Categories>(
        isExpanded: true,
        value: selectedCategory,
        decoration: InputDecoration(
            hintText: 'Select',
            border: OutlineInputBorder(),
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
        items: categoriesList!
            .map((label) => DropdownMenuItem(
          child: new Text(
            label.title ?? '',
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
            selectedCategory = value;
          });
        },
      );
    }
    else{
      return DropdownButtonFormField<Categories>(
        isExpanded: true,
        decoration: InputDecoration(
            hintText: 'Select',
            border: OutlineInputBorder(),
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
        items: categoriesList!
            .map((label) => DropdownMenuItem(
          child: new Text(
            label.title ?? '',
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
            selectedCategory = value;
          });
        },
      );
    }

  }

  //Country dropdown widget
  Widget countryDropDownWidget() {
    return DropdownButtonFormField<Countries>(
      isExpanded: true,
      value: selectedCountry,
      decoration: InputDecoration(
          hintText: 'Select',
          border: OutlineInputBorder(),
          contentPadding:
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
      items: countryList
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
          selectedCountry = value;
          getStatesList(selectedCountry!.id!);
        });
      },
    );
  }

  void getStatesList(int id) {
    stateList.clear();
    stateList = [];
    selectedState = null;
    cityList.clear();
    selectedCity = null;
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
      value: selectedState, // guard it with null if empty
      decoration: InputDecoration(
          hintText: 'Select',
          border: OutlineInputBorder(),
          contentPadding:
          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
      items: stateList
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
    cityList.clear();
    cityList = [];
    selectedCity = null;
    ApiService.getCityList(id).then((value) {
      setState(() {
        cityList = value.cities ?? [];
        print(cityList.length);
      });
    });
  }

  //City dropdown widget
  Widget cityDropDownWidget() {
    return selectedState!=null ?
    DropdownButtonFormField<Cities>(
      isExpanded: true,
      value: selectedCity,
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
  Future choosePhoto1() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File?  _image = File(pickedFile.path);
      setState(() {
        uploadImgPath1 = '';
        imgPath1 = _image!.path!;
      });
    } else {
      print('No image selected.');
    }
  }
  Future choosePhoto2() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File?  _image = File(pickedFile.path);
      setState(() {
        uploadImgPath2 = '';
        imgPath2 = _image!.path!;
      });
    } else {
      print('No image selected.');
    }
  }
  Future choosePhoto3() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File?  _image = File(pickedFile.path);
      setState(() {
        uploadImgPath3 = '';
        imgPath3 = _image!.path!;
      });
    } else {
      print('No image selected.');
    }
  }
}
class SaleType {
  int value;
  String name;
  SaleType(this.value, this.name);
}
