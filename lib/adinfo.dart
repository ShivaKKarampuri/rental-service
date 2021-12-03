import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_app/models/CategoriesListBean.dart';
import 'package:rent_app/models/CityListBean.dart';
import 'package:rent_app/models/CountryListBean.dart';
import 'package:rent_app/models/StateListBean.dart';
import 'package:rent_app/network/ApiService.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
class AdInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdInfoState();
  }
}

class AdInfoState extends State<AdInfoPage> {
  static final formKey = GlobalKey<FormState>();
  static TextEditingController title = new TextEditingController();
  static TextEditingController price = new TextEditingController();
  static TextEditingController tags = new TextEditingController();
  static TextEditingController description = new TextEditingController();
  static TextEditingController streetAddress = new TextEditingController();
  static TextEditingController pinCode = new TextEditingController();
  static String imgPath1 ="", imgPath2 ="", imgPath3 ="";

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
  static Countries? selectedCountry;
  List<States> stateList = <States>[];
  static States? selectedState;
  List<Cities> cityList = <Cities>[];
  static Cities? selectedCity;
  File? _image;
  final picker = ImagePicker();
  List<Categories>? categoriesList = <Categories>[];
  static Categories? selectedCategory;
  @override
  void initState() {
    super.initState();
    saleTypeDropdownMenuItems = buildDropDownMenuItems(saleTypeItems);
    selectedSaleTypeItem = saleTypeDropdownMenuItems[0].value;
    getCategoriesList();
    getCountryList();
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(child:
        Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                imgPath1.isNotEmpty ?
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
                        child:  Center(child: Image.file(File(imgPath1)))))
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
                imgPath2.isNotEmpty ?
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
                        child:  Center(child: Image.file(File(imgPath2)))))
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

                imgPath3.isNotEmpty ?
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
                        child:  Center(child: Image.file(File(imgPath3)))))
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
                  child:  countryDropDownWidget()),
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
                  child:  stateDropDownWidget()),
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
                  child:  cityDropDownWidget()),
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
        )));
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

  //Category dropdown widget
  Widget categoryDropDownWidget() {
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
  void getCategoriesList() {
    ApiService.getCategoriesList().then((value) {
      setState(() {
        categoriesList = value.categories ?? [];
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
