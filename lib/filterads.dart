import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/models/CategoriesListBean.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/ProgressHUD.dart';

class FilterAds extends StatefulWidget
{
  const FilterAds({Key? key}) : super(key: key);

  @override
  FilterAdsState createState() => FilterAdsState();
}

class FilterAdsState extends State<FilterAds> {

  final _key = GlobalKey<FormState>();
  bool _isLoading = false;

  RangeValues priceRangeValues = const RangeValues(0, 10000000);
  RangeValues spaceRangeValues = const RangeValues(0, 100000);

  List<Categories>? categoriesList = <Categories>[];
  Categories? selectedCategory;
  int? selectedCategoryId;
  List<String>? bedsList = [];
  String? selectedBed = '';
  List<String>? bathroomsList = [];
  String? selectedBathroom = '';
  @override
  void initState() {
    super.initState();
    getCategoriesList();
    bedsList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
    bathroomsList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  }
  goBack(BuildContext context){
    Navigator.pop(context);
  }
  void getCategoriesList() {
    ApiService.getCategoriesList().then((value) {
      setState(() {
        categoriesList = value.categories ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    var  screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor('E5E5E5'),
      appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('Filter Ads')
      ),
      body:ProgressHUD(
        child:   contentWidget(screenWidth),
        inAsyncCall: _isLoading,
        opacity: 0.0,
      ),
    );
  }
  Widget contentWidget(double screenWidth){
    return SingleChildScrollView(
        child:Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Form(
            key: _key,
            child: Card(
    color: Colors.white,
    shape:  OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: Colors.white)
    ),
    elevation: 3,
    child: Padding(
    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
    child:
    Column(crossAxisAlignment:CrossAxisAlignment.start,
                children:[

                  Text('Category \*',
                      style: TextStyle(
                          fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  Center(child: Container(
                      height: 50, child: categoriesListWidget())),
                  SizedBox(height: 10),
                  Text('Price Range',
                      style: TextStyle(
                          fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  priceRangesWidget(),
                  SizedBox(height: 5,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(priceRangeValues.start.round().toString(),
                          style: TextStyle(fontSize: 13,
                              color: Colors.grey,
                              fontFamily: "Nunito-Bold")),
                      Text(priceRangeValues.end.round().toString(),
                          style: TextStyle(fontSize: 13,
                              color: Colors.grey,
                              fontFamily: "Nunito-Bold")),
                    ],),
                  SizedBox(height: 10),
                  Text('No.of Beds \*',
                      style: TextStyle(
                          fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  Center(child: Container(
                      height: 50, child: bedsListWidget())),
                  SizedBox(height: 10),
                  Text('No.of Bathrooms \*',
                      style: TextStyle(
                          fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  Center(child: Container(
                      height: 50, child: bathroomsListWidget())),
                  SizedBox(height: 10),
                  Text('Space (Sq.ft)',
                      style: TextStyle(
                          fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  spaceRangesWidget(),
                  SizedBox(height: 5,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(spaceRangeValues.start.round().toString(),
                          style: TextStyle(fontSize: 13,
                              color: Colors.grey,
                              fontFamily: "Nunito-Bold")),
                      Text(spaceRangeValues.end.round().toString(),
                          style: TextStyle(fontSize: 13,
                              color: Colors.grey,
                              fontFamily: "Nunito-Bold")),
                    ],),
                  SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(
                                5.0, 0, 5, 0),
                            child: SizedBox(
                                height: 48,
                                width: 145,
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
                                    setState(() {
                                      selectedCategory = null;
                                      selectedCategoryId = 0;
                                      selectedBed = '';
                                      selectedBathroom = '';
                                      priceRangeValues = RangeValues(0, 10000000);
                                      spaceRangeValues = RangeValues(0, 100000);

                                    });
                                  },
                                ))),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(
                                5.0, 0, 5, 0),
                            child: SizedBox(
                                height: 48,
                                width: 145,
                                child: TextButton(
                                  child: Text("Filter",
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
                                    if(selectedCategory == null){
                                      this.showToast('Please Select Category');
                                    }
                                    else if(selectedBed!.isEmpty){
                                      this.showToast('Please Select No.of Beds');
                                    }
                                    else if(selectedBathroom!.isEmpty){
                                      this.showToast('Please Select No.of Bathrooms');
                                    }
                                    else{
                                      filterAds();
                                      // filterResults(priceRangeValues.start.round(), priceRangeValues.end.round());

                                    }

                                  },
                                ))),
                      ]),
                  SizedBox(height: 30),
                ]))))));
  }
  Widget priceRangesWidget(){
    return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.white,
          thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 15.0),
          overlayShape: RoundSliderOverlayShape(
              overlayRadius: 5.0),
          tickMarkShape: RoundSliderTickMarkShape(),
          activeTickMarkColor: HexColor("#4F3592"),
          inactiveTickMarkColor: Colors.red[100],
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          valueIndicatorColor: HexColor("#4F3592"),
          valueIndicatorTextStyle: TextStyle(
            color: Colors.white,
          ),),
        child: RangeSlider(
          activeColor: HexColor("F1635D"),
          inactiveColor: HexColor('#ffd9d9'),
          values: priceRangeValues,
          min: 0,
          max: 10000000,
          divisions: 20,
          labels: RangeLabels(
            priceRangeValues.start.round().toString(),
            priceRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              priceRangeValues = values;
            });
          },
        ));
  }

  Widget spaceRangesWidget(){
    return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.white,
          thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 15.0),
          overlayShape: RoundSliderOverlayShape(
              overlayRadius: 5.0),
          tickMarkShape: RoundSliderTickMarkShape(),
          activeTickMarkColor: HexColor("#4F3592"),
          inactiveTickMarkColor: Colors.red[100],
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          valueIndicatorColor: HexColor("#4F3592"),
          valueIndicatorTextStyle: TextStyle(
            color: Colors.white,
          ),),
        child: RangeSlider(
          activeColor: HexColor("F1635D"),
          inactiveColor: HexColor('#ffd9d9'),
          values: spaceRangeValues,
          min: 0,
          max: 100000,
          divisions: 20,
          labels: RangeLabels(
            spaceRangeValues.start.round().toString(),
            spaceRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              spaceRangeValues = values;
            });
          },
        ));
  }

  Widget categoriesListWidget(){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      //controller: _controller,
      itemCount: categoriesList!.length,
      shrinkWrap: true,
      //   reverse : true,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {

        return  Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child : InkWell(onTap:(){
              setState(() {
                selectedCategory = categoriesList![index];
                selectedCategoryId = selectedCategory!.id;
              });
            },
                child: Container(
                  width: 110,
                  height: 36,
                  decoration: BoxDecoration(
                      color: selectedCategoryId == categoriesList![index].id ?  Colors.red : HexColor('efeff4'),
                      borderRadius:BorderRadius.circular(5.0)
                  ),
                  child:Center(child: Text(categoriesList![index].title ?? '', style: TextStyle(fontSize: 16,color: selectedCategoryId == categoriesList![index].id ? Colors.white : Colors.red, fontFamily: "Nunito-Regular"))),

                )));
      },
    );
  }

  Widget bedsListWidget(){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      //controller: _controller,
      itemCount: bedsList!.length,
      shrinkWrap: true,
      //   reverse : true,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {

        return  Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child : InkWell(onTap:(){
              setState(() {
                selectedBed = bedsList![index];
              });
            },
                child: Container(
                  width: 50,
                  height: 36,
                  decoration: BoxDecoration(
                      color: selectedBed == bedsList![index] ?  Colors.red : HexColor('efeff4'),
                      borderRadius:BorderRadius.circular(5.0)
                  ),
                  child:Center(child: Text(bedsList![index] ?? '', style: TextStyle(fontSize: 16,color: selectedBed == bedsList![index] ? Colors.white : Colors.red, fontFamily: "Nunito-Regular"))),

                )));
      },
    );
  }

  Widget bathroomsListWidget(){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      //controller: _controller,
      itemCount: bathroomsList!.length,
      shrinkWrap: true,
      //   reverse : true,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {

        return  Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child : InkWell(onTap:(){
              setState(() {
                selectedBathroom = bathroomsList![index];
              });
            },
                child: Container(
                  width: 50,
                  height: 36,
                  decoration: BoxDecoration(
                      color: selectedBathroom == bathroomsList![index] ?  Colors.red : HexColor('efeff4'),
                      borderRadius:BorderRadius.circular(5.0)
                  ),
                  child:Center(child: Text(bathroomsList![index] ?? '', style: TextStyle(fontSize: 16,color: selectedBathroom == bathroomsList![index] ? Colors.white : Colors.red, fontFamily: "Nunito-Regular"))),

                )));
      },
    );
  }

  void showToast(String msg)
  {
    Toast.show(msg, context);
    Timer(Duration(seconds: 3), () {
      Toast.dismiss();
    });
  }

  void filterAds() {
    ApiService.filterAds(priceRangeValues.start.toString(), priceRangeValues.end.toString(),
    selectedBed!, selectedBathroom!, spaceRangeValues.start.toString(), spaceRangeValues.end.toString()).then((value) {

      if(value.success==true && value.ads!.isNotEmpty){
        Navigator.pop(context, value.ads ?? []);
      }
      else{
        this.showToast('No Ads Found');
      }


    });
  }
}