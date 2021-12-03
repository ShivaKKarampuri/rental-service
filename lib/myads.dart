import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/models/MyAdsResponse.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/updateadinfo.dart';
import 'package:rent_app/updatepost.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/ProgressHUD.dart';
import 'package:rent_app/utils/kf_drawer.dart';

import 'addetails.dart';
class MyAdsPage extends KFDrawerContent{
  @override
  MyAdsPageState createState() =>  MyAdsPageState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class  MyAdsPageState extends State< MyAdsPage> {
  List<Ads> adsList = <Ads>[];
  Set<Ads> filteredAdsList = new Set<Ads>();
  bool _isLoading = false;
  TextEditingController searchController = new TextEditingController();
  final debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    getMyAds();
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
              body:ProgressHUD(
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

              ))

          ));
  }

  Widget contentWidget() {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
        child: GestureDetector(
        onTap: () {
      FocusScope.of(context).unfocus();
    },
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Ads', style: TextStyle(fontSize: 32, fontFamily: "Nunito-Bold")),
                  SizedBox(height: 10,),
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
                          controller: searchController,
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search Ad',
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
                          ),
                        onChanged: (value) {
                          debouncer.run(() {
                            TextSelection
                            previousSelection =
                                searchController
                                    .selection;
                            searchController.text =
                                value;
                            searchController.selection =
                                previousSelection;
                            filterSearchResults(value);
                          });
                        },)),
                  SizedBox(height: 10),
                  adsList.isNotEmpty ? adsListViewWidget() : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child:Center(
                      child: Text('No Ads Found',
                          style: TextStyle(color: Colors.redAccent, fontSize: 14, fontFamily: "Nunito-Bold"))))

                ])
        )));
  }

  void getMyAds() {
    _isLoading = true;
    ApiService.getMyAds().then((value) {
      setState(() {
        _isLoading = false;
   //     if(value.success ?? false){
          adsList = value.ads ?? [];
          print(adsList.length);
 //       }
      });
    });
  }

 Widget adsListViewWidget() {
   return ListView.builder(
     itemCount: adsList.length,
     shrinkWrap: true,
    //   reverse : true,
     physics: NeverScrollableScrollPhysics(),
     itemBuilder: (context, index) {
       return Padding(
           padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
         child :  InkWell(onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => AdDetailsPage(id: adsList[index].id.toString())));
         },
         child: Card(
               color: Colors.white,
           shape:  OutlineInputBorder(
               borderRadius: BorderRadius.circular(15),
               borderSide: BorderSide(color: Colors.white)
           ),
               elevation: 8,
               child:
               Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

               Stack(
               children: <Widget>[
                 Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
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
                 ],),
                      Align(alignment: Alignment.topRight,
                           child:
                           Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                               child: Row(mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               InkWell(onTap: () async {

                                 var editAd = await   Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage(id: adsList[index].id.toString())));
                                 getMyAds();
                           },
                             child:Icon(
                                 Icons.edit,
                                 color: Colors.red,
                                 size: 24.0,
                                 semanticLabel: 'Edit',
                             )),
                               SizedBox(width: 10,),
                               InkWell(onTap: (){
                                 showDeleteDialog(context, adsList[index].id);

                               },
                                   child:Icon(
                                     Icons.delete,
                                     color: Colors.red,
                                     size: 30.0,
                                   )),
                             ],))),
                ]),

                     ],
                   ),

                 )));
     },
   );
 }

  void showDeleteDialog(BuildContext context, int? id) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Ad'),
          content: Text("Are you sure you want to delete this ad?"),
          actions: <Widget>[
            TextButton(
              child: Text("YES"),
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
               deleteAd(context, id);
              },
            ),
            TextButton(
              child: Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteAd(BuildContext context, int? id) {

    ApiService.deleteAd(id.toString()).then((value) {
      if(value.success == true){
        setState(() {
          _isLoading = false;
        });
        this.showToast('Ad Deleted Successfully');
        Navigator.of(context).pop();
        adsList.clear();
        getMyAds();
      }

    });
  }

  void showToast(String msg) {
    Toast.show(msg, context);
    Timer(Duration(seconds: 3), () {
      Toast.dismiss();
    });
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredAdsList.addAll(this.adsList);
    });

    if (query.length > 0) {
      Set<Ads> searcherData = new Set<Ads>();
      Set<Ads> set = Set.from(filteredAdsList);

      set.forEach((Ads item) {
        if (item!.title!
            .toLowerCase()
            .contains(query.toLowerCase())) {
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
