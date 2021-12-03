import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:rent_app/models/AmenitiesResponse.dart';
import 'package:rent_app/models/CountryListBean.dart';
import 'package:rent_app/network/ApiService.dart';

class PropertyInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PropertyInfoState();
  }
}

class PropertyInfoState extends State<PropertyInfo> {
  static final formKey = GlobalKey<FormState>();
  static TextEditingController beds = new TextEditingController();
  static TextEditingController hall = new TextEditingController();
  static TextEditingController bathroom = new TextEditingController();
  static TextEditingController space = new TextEditingController();
  static TextEditingController builtYear = new TextEditingController();
  static TextEditingController floors = new TextEditingController();
  List<Amenities> amenitiesList = <Amenities>[];
  static List<Amenities>? selectedAmenitiesList = [];
  List<MultiSelectItem<Amenities>> _items = [];

  @override
  void initState() {
    super.initState();
    getAmenitiesList();
    print(selectedAmenitiesList!.length);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child:
    Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
    child:
    Container(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('No.of Beds', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                    controller: beds,
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
              Text('No.of Hall', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                      controller: hall,
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
              Text('No.of Bathroom', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                      controller: bathroom,
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
              Text('Space (Sq)', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                      controller: space,
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
              Text('Built Year', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                    controller: builtYear,
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
              Text('No.of Floors', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                    controller: floors,
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
              Text('Amenities \*', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
              SizedBox(height: 10),
              Container(
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
                  child:   MultiSelectDialogField(
                    items: _items ?? [],
                    title: Text("Select Amenities"),
                    selectedColor: Colors.red,
                    searchable: true,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    onConfirm: (results) {
                      selectedAmenitiesList = results.cast<Amenities>();
                    },
                  ),),

            ],
          ),
        ))));
  }

  void getAmenitiesList() {
    ApiService.getAmenitiesList().then((value) {
      setState(() {
        amenitiesList = value.amenities ?? [];
        _items = amenitiesList
            .map((amenity) => MultiSelectItem<Amenities>(amenity, amenity!.title!))
            .toList();
      });
    });
  }

}