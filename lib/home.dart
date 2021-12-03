import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/utils/kf_drawer.dart';
class HomePage extends KFDrawerContent{
  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage> {
  RangeValues _currentRangeValues = const RangeValues(4000, 8000);
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
                                  onPressed: widget.onMenuPressed!,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                        child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                          Container(height: 60, child: headerWidget(),),
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

  Widget headerWidget() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Rent Home', style: TextStyle(fontSize: 32, fontFamily: "Nunito-Bold")),
            ]));
  }

  Widget footerWidget() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex:4,child: Padding(
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
    return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child:
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Center(child:  Image.asset(
                        "assets/icon_homefeed.png",
                      )),
                        SizedBox(height: 20),
                        Center(child: Text('Welcome to Your Feed!', style: TextStyle(fontSize: 24, fontFamily: "Nunito-Bold"))),
                        SizedBox(height: 20),
                       Center(child: Text('Search and save homes to see realtime updates', style: TextStyle(fontSize: 14, fontFamily: "Nunito-Regular"))),
                        Center(child: Text('on the things you care about most.', style: TextStyle(fontSize: 14, fontFamily: "Nunito-Regular")))

                      ],
                    ),
                  ),
        );
  }

}
