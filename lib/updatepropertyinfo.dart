import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:rent_app/models/AmenitiesResponse.dart';
import 'package:rent_app/models/CountryListBean.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/updatepost.dart';

class UpdatePropertyInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UpdatePropertyInfoState();
  }
}

class UpdatePropertyInfoState extends State<UpdatePropertyInfo> {
  static final formKey = GlobalKey<FormState>();
  static TextEditingController beds = new TextEditingController();
  static TextEditingController hall = new TextEditingController();
  static TextEditingController bathroom = new TextEditingController();
  static TextEditingController space = new TextEditingController();
  static TextEditingController builtYear = new TextEditingController();
  static TextEditingController floors = new TextEditingController();
 List<Amenities> amenitiesList = <Amenities>[];
  static List<Amenities> selectedAmenitiesList = <Amenities>[];
  List<MultiSelectItem<Amenities>> _items = [];

  @override
  void initState() {
    super.initState();
    getAmenitiesList();

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
                  TextFormField(
                    readOnly: true,
                    showCursor: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Select',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0)),
                    onTap: () {
                      locationMultiSelectPopup(context);
                    },
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius:BorderRadius.circular(
                  //         4.0),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.5),
                  //         spreadRadius: 1,
                  //         blurRadius: 7,
                  //         offset: Offset(0, 3), // changes position of shadow
                  //       ),
                  //     ],
                  //   ),
                  //   child:   MultiSelectDialogField(
                  //     items: _items ?? [],
                  //   //  initialValue:[(Amenities(id: 1, title: '24/7 power supply'))],
                  //     initialValue: selectedAmenitiesList,
                  //     title: Text("Select Amenities"),
                  //     selectedColor: Colors.red,
                  //     searchable: true,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white.withOpacity(0.1),
                  //       borderRadius: BorderRadius.all(Radius.circular(40)),
                  //       border: Border.all(
                  //         color: Colors.white,
                  //         width: 1,
                  //       ),
                  //     ),
                  //     onConfirm: (results) {
                  //       selectedAmenitiesList = results.cast<Amenities>();
                  //     },
                  //   ),),

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
      selectedAmenitiesList = UpdatePostState.selectedAmenitiesList;



      });
    });
  }
  @pragma('multiSelectPopup')
  Future<void> locationMultiSelectPopup(BuildContext context) async {
    Map<String, bool> list = {};

    Map<String, bool> mainlist = {};

    TextEditingController tc = new TextEditingController();

    for (int i = 0; i < (this.amenitiesList?.length ?? 0); i++) {
      int index = UpdatePropertyInfoState.selectedAmenitiesList?.indexWhere(
              (prod) => prod?.title == this.amenitiesList?[i].title) ??
          0;

      if (index == -1) {
        list[this.amenitiesList?[i].title ?? ''] = false;
      } else {
        list[this.amenitiesList?[i].title ?? ''] = true;
      }
    }
    mainlist = list;
    return await showDialog(
        context: context,
        builder: (context) {
          double height = MediaQuery.of(context).size.height;

          return StatefulBuilder(builder: (context, setState2) {
            onItemChanged(String value) {
              setState2(() {
                List<String> items = mainlist.keys
                    .where((element) =>
                    element.toLowerCase().contains(value.toLowerCase()))
                    .toList();

                list = {};

                mainlist.forEach((k, v) {
                  for (int i = 0; i < items.length; i++) {
                    if (items[i] == k) {
                      list[k] = v;
                    }
                  }
                });
              });
            }

            return AlertDialog(
              content: Form(
                // key: sampleCollectorForm,
                  child: Container(
                    width: 400,
                    height:
                    height < list.length * 60.0 ? list.length * 60.0 : height,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: tc,
                            decoration: InputDecoration(
                              hintText: 'Search Here...',
                            ),
                            onChanged: onItemChanged,
                          ),
                        ),
                        Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: list.keys.map((String key) {
                                return new CheckboxListTile(
                                  title: new Text(key),
                                  value: list[key],
                                  activeColor: Colors.red,
                                  checkColor: Colors.white,
                                  onChanged: (bool? value) {
                                    setState2(() {
                                      list[key] = value!;
                                      mainlist[key] = value;
                                    });
                                  },
                                );
                              }).toList(),
                            )),
                        Center(
                          child: TextButton(
                              child: Text('Select'),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.red,
                                onSurface: Colors.grey,
                              ),
                              onPressed: () {
                                var holder_1 = [];

                                list.forEach((key, value) {
                                  if (value == true) {
                                    holder_1.add(key);
                                  }
                                });

                                UpdatePropertyInfoState.selectedAmenitiesList = [];

                                for (int i = 0; i < holder_1.length; i++) {
                                  for (int j = 0;
                                  j < (this.amenitiesList?.length ?? 0);
                                  j++) {
                                    if (holder_1[i] ==
                                        (amenitiesList?[j].title ?? '')) {
                                      UpdatePropertyInfoState.selectedAmenitiesList
                                          ?.add(this.amenitiesList![j]);
                                    }
                                  }
                                }
                                Navigator.pop(context);

                                setState(() {});
                              }),
                        )
                      ],
                    ),
                  )),
              title: Text('Locations'),
            );
          });
        });
  }

}