import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/utils/kf_drawer.dart';
class SearchPage extends KFDrawerContent{
  @override
  SearchPageState createState() => SearchPageState();
}
class SearchPageState extends State<SearchPage> {
  RangeValues _currentRangeValues =  RangeValues(4000, 8000);
  String _selected = '';
  List<String> _items = ['Any', '1+', '2+', '3+', '4+', '5+'];
  TextEditingController selectedBed = new TextEditingController();
  bool buyHouse = false;
  bool rentHouse = false;
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
           backgroundColor: HexColor('FFFFFF'),
           body:
           SafeArea(
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
                     Container(height: 60, child: footerWidget()),
                   ]))
                 ],
               ),

           )

                   ));
  }

  void showBedOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            padding: EdgeInsets.all(8),
            height: 200,
            alignment: Alignment.center,
            child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (context, int) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child : Text(_items[index], style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold"))),
                      onTap: () {
                        setState(() {
                          _selected = _items[index];
                          selectedBed.text = _selected;
                        });
                        Navigator.of(context).pop();
                      }
                  );
                }
            ),
          );
        }
    );
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
                    child: Text("Skip",
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
                    child: Text("Start Searching",
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

  Widget contentWidget() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Let get started', style: TextStyle(fontSize: 32, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  Text('Find a home you’ll love today', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Regular")),

        SizedBox(height: 20,),
        Row( crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex:2,child: Container(height:155,
                            child:  Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: buyHouse ? HexColor('#4F3592') : HexColor("#ffd9d9"),
                          elevation: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                buyHouse = true;
                                rentHouse = false;
                              });
                            },
                         child : Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Column(children: [
                              buyHouse ?
                              Image.asset(
                                "assets/house-white.png",
                                height: 60,
                                width: 60,
                              ) :
                              Image.asset(
                                "assets/house.png",
                                height: 60,
                                width: 60,
                              ),
                              SizedBox(height: 20),
                              Text('Buy', style: TextStyle(color: buyHouse ? HexColor('#ffffff') : HexColor('#454555'),fontSize: 16, fontFamily: "Nunito-Bold")),

                            ],),
                          )),
                        ))),
                        SizedBox(width: 10),
                        Expanded(flex:2,child: Container(height:155, child:  Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: rentHouse ? HexColor('#4F3592') : HexColor("#ffd9d9"),
                          elevation: 1,
                          child:InkWell(
                            onTap: () {
                              setState(() {
                                buyHouse = false;
                                rentHouse = true;
                              });
                            },
                            child : Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Column(children: [
                              rentHouse ?
                              Image.asset(
                                "assets/house-white.png",
                                height: 60,
                                width: 60,
                              ) :
                              Image.asset(
                                "assets/house.png",
                                height: 60,
                                width: 60,
                              ),
                              SizedBox(height: 20),
                              Text('Rent', style: TextStyle(color: rentHouse ? HexColor('#ffffff') : HexColor('#454555'),fontSize: 16, fontFamily: "Nunito-Bold")),

                            ],),
                          )),
                        ))),
                      ]),
                  SizedBox(height: 15,),
                  Text('Where', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  Container(height: 48, child :TextFormField(
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
                        hintText: 'Placeholder',
                        hintStyle: TextStyle(fontSize: 16, color:HexColor("#CCCCD0"), fontFamily: "Nunito-Regular"),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15), // add padding to adjust icon
                          child: Icon(Icons.location_on_rounded),
                        ),
                      ))),
                  SizedBox(height: 15),
                  Text('Price Range', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
            SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                  tickMarkShape: RoundSliderTickMarkShape(),
                  activeTickMarkColor: HexColor("#4F3592"),
                  inactiveTickMarkColor: Colors.red[100],
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: HexColor("#4F3592"),
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                  ),                ),
                child:    RangeSlider(
                    activeColor: HexColor("F1635D"),
                    inactiveColor: HexColor('#ffd9d9'),
                    values: _currentRangeValues,
                    min: 1000,
                    max: 10000,
                    divisions: 5,
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
                  SizedBox(height: 15),
                  Text('How many bed?', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // FocusScope.of(context).requestFocus(new FocusNode());
                      showBedOptions(context);
                    },
                    child: IgnorePointer(
                        child: Container(height: 48, child:TextFormField(
                            controller: selectedBed,
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
                              hintText: 'Select',
                              hintStyle: TextStyle(fontSize: 16, color:HexColor("#CCCCD0"), fontFamily: "Nunito-Regular"),
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15), // add padding to adjust icon
                                child: Icon(Icons.king_bed),
                              ),
                            ),
                            onSaved: (value) {}))),
                  ),
                  SizedBox(height: 20),
                ])

        ));
  }

}
