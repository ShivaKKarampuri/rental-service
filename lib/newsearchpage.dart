import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/addetails.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/utils/ProgressHUD.dart';
import 'package:rent_app/utils/kf_drawer.dart';

import 'models/MyAdsResponse.dart';
class NewSearchPage extends KFDrawerContent{
  @override
  NewSearchPageState createState() => NewSearchPageState();
}
class NewSearchPageState extends State<NewSearchPage> {

  TextEditingController cityTEC = new TextEditingController();
  TextEditingController pinCodeTEC = new TextEditingController();
  List<Ads> adsList = <Ads>[];
  Set<Ads> filteredAdsList = new Set<Ads>();
  bool _isLoading = false;
  RangeValues _currentRangeValues = const RangeValues(4000, 8000);


  var _currentSelection = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home :  Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: HexColor('FFFFFF'),
              body:  SafeArea(
    child: ProgressHUD(
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
                          Expanded(child:  contentWidget()),
                          Container(height: 0),
                        ]))
                  ],
                ),

              )

    ) ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: FloatingActionButton(
              // isExtended: true,
              child: Icon(Icons.filter_alt_outlined),
              backgroundColor: Colors.red,
              onPressed: () {
               showFilterModelSheet();
              },
            ),));
  }

  Widget contentWidget() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(height: 48, child :TextFormField(
                    controller: cityTEC,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                            color: HexColor("#F1635D"),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                            color: HexColor("#EEEEEF"),
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Search with City',
                        hintStyle: TextStyle(fontSize: 16, color:HexColor("#CCCCD0"), fontFamily: "Nunito-Regular"),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15), // add padding to adjust icon
                          child: Icon(Icons.location_city),
                        ),
                      ))),
                  SizedBox(height: 10),
                  Center(child:Text('OR', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold"))),
                  SizedBox(height: 10),
                  Container(height: 48, child :TextFormField(
                    controller: pinCodeTEC,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                            color: HexColor("#F1635D"),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                            color: HexColor("#EEEEEF"),
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Search with PinCode',
                        hintStyle: TextStyle(fontSize: 16, color:HexColor("#CCCCD0"), fontFamily: "Nunito-Regular"),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15), // add padding to adjust icon
                          child: Icon(Icons.pin_drop_outlined),
                        ),
                      ))),
                  SizedBox(height: 12,),
                  Center(child:SizedBox(
                      height: 48,
                      width: 156,
                      child: TextButton(
                        child: Text("Search",
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
                          FocusManager.instance.primaryFocus!.unfocus();
                          submit();
                        },
                      ))),
                  SizedBox(height: 12),
                  adsList.isNotEmpty ? adsListViewWidget() : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child:Center(
                          child: Text('No Ads Found',
                              style: TextStyle(color: Colors.redAccent, fontSize: 14, fontFamily: "Nunito-Bold"))))

                ])

        ));
  }

  Widget adsListViewWidget() {
    return ListView.builder(
      itemCount: adsList.length,
      // reverse: true,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child : InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdDetailsPage(id: adsList[index].id.toString())));
            },
                child: Card(
                  color: Colors.white,
                  shape:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  elevation: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          child: adsList[index].photos !="" ?
                          Image.network(
                              'http://classified.ecodelinfotel.com/public/img/cmspage/'+adsList[index]!.photos!,
                              height: 250.0,
                              width: MediaQuery.of(context).size.width,
                              fit:BoxFit.cover): Image.asset('assets/sample1.jpeg', width: MediaQuery.of(context).size.width,
                            fit:BoxFit.cover, height: 250,)
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                            Text(adsList[index].title ?? '', style: TextStyle(color:HexColor("F1635D"),fontSize: 18, fontFamily: "Nunito-Bold")),
                            SizedBox(height: 5),
                            Text("Rs." + adsList[index].price.toString(), style: TextStyle(fontSize: 18, fontFamily: "Nunito-Bold")),
                          ],))
                    ],
                  ),
                )));
      },
    );
  }

  void submit() {
    setState(() {
      _isLoading = true;
      adsList.clear();
    });
    ApiService.searchAd(cityTEC.text ?? '', pinCodeTEC.text ?? '').then((value) {
      setState(() {
        _isLoading = false;
        adsList = value.ads ?? [];
      });
    });
  }

  void showFilterModelSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context)
    {
      return StatefulBuilder(builder: (BuildContext context,
          void Function(void Function()) setState) {
        return SafeArea(child: Container(height: 280, child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5),
                Text('Filter', textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20,
                        color: Colors.red,
                        fontFamily: "Nunito-Bold")),
                SizedBox(height: 5),
                Divider(thickness: 1, color: Colors.red,),
                SizedBox(height: 10),
                Text('Price Range',
                    style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                SizedBox(height: 10),
                SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 15.0),
                      overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 30.0),
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
                      values: _currentRangeValues,
                      min: 1000,
                      max: 100000,
                      divisions: 12,
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                        });
                      },
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( _currentRangeValues.start.round().toString(),
                      style: TextStyle(fontSize: 16,
                          color: Colors.black,
                          fontFamily: "Nunito-Bold")),
                  Text(_currentRangeValues.end.round().toString(),
                      style: TextStyle(fontSize: 16,
                          color: Colors.black,
                          fontFamily: "Nunito-Bold")),
                ],),
                SizedBox(height: 20),
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
                                  //submit();
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
                                  Navigator.pop(context);
                                  filterSearchResults(_currentRangeValues.start.round(), _currentRangeValues.end.round());

                                },
                              ))),
                    ])
              ],
            ))));
      });
    });
  }

  void filterSearchResults(int startPrice, int endPrice) {
    setState(() {
      filteredAdsList.addAll(this.adsList);
    });

    if (startPrice > 0 && endPrice > 0) {
      Set<Ads> searcherData = new Set<Ads>();
      Set<Ads> set = Set.from(filteredAdsList);

      set.forEach((Ads item) {
        if (item!.price! >= startPrice  && item!.price! <= endPrice) {
          searcherData.add(item);
        }
      });
      setState(() {
        this.adsList.clear();
        adsList.addAll(searcherData);
      });
    } else {
      setState(() {
        this.adsList.clear();
        adsList.addAll(filteredAdsList);
      });
    }
  }
}
