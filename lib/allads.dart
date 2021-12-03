import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/addetails.dart';
import 'package:rent_app/models/CategoriesListBean.dart';
import 'package:rent_app/models/MyAdsResponse.dart';
import 'package:rent_app/network/ApiService.dart';
import 'package:rent_app/utils/CustomToast.dart';
import 'package:rent_app/utils/kf_drawer.dart';

import 'filterads.dart';
class AllAdsPage extends KFDrawerContent{
  @override
  AllAdsPageState createState() =>  AllAdsPageState();
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

class  AllAdsPageState extends State< AllAdsPage> {
  List<Ads> adsList = <Ads>[];
  Set<Ads> filteredAdsList = new Set<Ads>();
  TextEditingController searchController = new TextEditingController();
  final debouncer = Debouncer(milliseconds: 500);
  late RangeValues _currentRangeValues;
  List<Categories>? categoriesList = <Categories>[];
  Categories? selectedCategory;
  int? selectedCategoryId;
  List<String>? bedsList = [];
  String? selectedBed = '';


  @override
  void initState() {
    super.initState();
    getCategoriesList();
    bedsList = ['1', '2', '3', '4', '5'];
    getAllAds();

  }
  void getCategoriesList() {
    ApiService.getCategoriesList().then((value) {
      setState(() {
        categoriesList = value.categories ?? [];
      });
    });
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
                child: getNewWidget(),
              )

          ));
  }



  Widget getNewWidget(){

    return SingleChildScrollView(

      child:  Container(
        child: Stack(
          children: [

            Image.network(
                'https://images.unsplash.com/photo-1549517045-bc93de075e53?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZmFtaWx5JTIwaG91c2V8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80',
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                fit:BoxFit.cover
            ),


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
                )
            ),

            Container(
              margin: EdgeInsets.only( top: 180 , left: 25 , right: 25 ),

              child: Column(
                children: [

                  Row(

                    children: [
                      Image.asset(
                        "assets/marker.png",
                        height: 20,
                        width: 20,
                        color: Colors.white,
                      ),

                      SizedBox( width: 5,),

                      Text('NEW YORK CITY', style: TextStyle( color : Colors.white, fontSize: 18, fontFamily: "Nunito-Bold")),

                    ],

                  ),


                  SizedBox(height: 15,),

                  Stack(

                    children: [


                      Container(
                          height:48,
                          // width: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:BorderRadius.circular(
                                50.0),
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
                              prefixIcon: Icon(Icons.search , color: Colors.black87,),

                              hintText: 'Search Ad',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide(
                                  // color: Colors.red,
                                  color: Colors.transparent,

                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
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
                            },)
                      ),


                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only( right: 15 , top: 10),

                        child: InkWell(
                          onTap: () async{

                            List<Ads> adList = await  Navigator.push(context, MaterialPageRoute(builder: (context) => FilterAds()));
                            setState(() {
                              this.adsList = adList;
                            });
                            },
                            child: Image.asset(
                          'assets/filter.png',
                          width: 25,
                          fit:BoxFit.cover,
                          height: 25,
                        )),

                      )


                    ],

                  ),

                  SizedBox(height: 10,),

                  // Row(
                  //
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //
                  //
                  //
                  //     Container(
                  //         height:38,
                  //         width: 100,
                  //         decoration: BoxDecoration(
                  //           color: Colors.deepPurple,
                  //           borderRadius:BorderRadius.circular(
                  //               50.0),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               spreadRadius: 1,
                  //               blurRadius: 7,
                  //               offset: Offset(0, 3), // changes position of shadow
                  //             ),
                  //           ],
                  //         ),
                  //         child: Center(
                  //           child:  Text('Buy', style: TextStyle( color : Colors.white, fontSize: 18, fontFamily: "Nunito-Regular")),
                  //         )
                  //     ),
                  //
                  //     SizedBox(width: 10,),
                  //
                  //     Container(
                  //         height:38,
                  //         width: 100,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius:BorderRadius.circular(
                  //               50.0),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               spreadRadius: 1,
                  //               blurRadius: 7,
                  //               offset: Offset(0, 3), // changes position of shadow
                  //             ),
                  //           ],
                  //         ),
                  //         child: Center(
                  //           child:  Text('Rent', style: TextStyle( color : Colors.black, fontSize: 18, fontFamily: "Nunito-Regular")),
                  //         )
                  //     ),
                  //
                  //     SizedBox(width: 10,),
                  //
                  //     Container(
                  //         height:38,
                  //         width: 100,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius:BorderRadius.circular(
                  //               50.0),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               spreadRadius: 1,
                  //               blurRadius: 7,
                  //               offset: Offset(0, 3), // changes position of shadow
                  //             ),
                  //           ],
                  //         ),
                  //         child: Center(
                  //           child:  Text('Sold', style: TextStyle( color : Colors.black, fontSize: 18, fontFamily: "Nunito-Regular")),
                  //         )
                  //     ),
                  //
                  //   ],
                  //
                  // ),


                  SizedBox(height: 10,),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(adsList.length.toString()+' New Listing', style: TextStyle( color : Colors.black, fontSize: 22, fontFamily: "Nunito-Regular")),


                      Text('View all', style: TextStyle( color : Colors.deepOrangeAccent, fontSize: 18, fontFamily: "Nunito-Regular")),

                    ],
                  ),

                  SizedBox(height: 10),

                  adsList.isNotEmpty ? getNewList() : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child:Center(
                          child: Text('No Ads Found', style: TextStyle(color: Colors.redAccent, fontSize: 14, fontFamily: "Nunito-Bold")
                          )
                      )
                  ),


                  getNewContentWidget()
                ],

              ),

            )

          ],

        ),

      ),

    );

  }



  void getAllAds() {
    ApiService.getAllAds().then((value) {
      setState(() {
        List<int> prices = [];
            adsList = value.ads ?? [];
        adsList.forEach((element) {
          prices.add(element?.price ?? 0);
        });
        var minPrice = prices.reduce(min);
        var maxPrice = prices.reduce(max);
        _currentRangeValues = RangeValues(minPrice!=0 ? double.parse(minPrice.toString()) : 1000, double.parse(maxPrice.toString()));
      });
    });
  }


  Widget getNewList(){

    return
      // Expanded(
      // child:
      Container(
        height: 275,
        child:  ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: adsList.length ,
          itemBuilder: (BuildContext context, int index) =>
              InkWell(
              onTap:  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdDetailsPage(id: adsList[index].id.toString())));
              },

              child: Container(
                margin: EdgeInsets.only(right: 10 , bottom: 5),
                width: 180,

                child: Card(
                  color: Colors.white,
                  shape:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          child: adsList[index].photos !="" ?
                          Image.network(
                              'http://classified.ecodelinfotel.com/public/img/cmspage/'+adsList[index]!.photos!,
                              height: 130.0,
                              width: 180,
                              fit:BoxFit.cover
                          ):
                          Image.asset(
                            'assets/sample1.jpeg',
                            width: 180,
                            fit:BoxFit.cover,
                            height: 130,
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(

                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [

                              Text(adsList[index].title ?? '', style: TextStyle(color:HexColor("F1635D"),fontSize: 14, fontFamily: "Nunito-Bold")),

                              SizedBox(height: 3),

                              Text("Rs." + adsList[index].price.toString(), style: TextStyle(fontSize: 15, fontFamily: "Nunito-Bold")),

                              SizedBox(height: 3),

                              Text(
                                getAddress(adsList[index]),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontFamily: 'Nunito-Bold',
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 3),


                              Row(

                                children: [


                                  Image.asset(
                                    'assets/bed.png',
                                    width: 20,
                                    fit:BoxFit.cover,
                                    height: 20,
                                    color: Colors.black26,
                                  ),

                                  SizedBox(width: 3),

                                  Text("1", style: TextStyle(fontSize: 15, fontFamily: "Nunito-Bold")),

                                  SizedBox(width: 8),

                                  Image.asset(
                                    'assets/ic_bathroom.png',
                                    width: 15,
                           fit:BoxFit.cover,
                                    height: 15,
                                    color: Colors.black26,

                                  ),

                                  SizedBox(width: 3),

                                  Text("1", style: TextStyle(fontSize: 15, fontFamily: "Nunito-Bold")),

                                  SizedBox(width: 8),

                                  Image.asset(
                                    'assets/ic_square.png',
                                    width: 15,
                                    fit:BoxFit.cover,
                                    height: 15,
                                    color: Colors.black26,
                                  ),

                                  SizedBox(width: 3),

                                  Text("350", style: TextStyle(fontSize: 15, fontFamily: "Nunito-Bold")),


                                ],

                              )

                            ],
                          )
                      )





                    ],

                  ),

                ),

              )



          ),
        ),
      );
    // );

  }


  Widget getNewContentWidget() {

    return  Container(

      child:  adsList.isNotEmpty ? adsListViewWidget() : Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child:Center(
              child: Text('No Ads Found',
                  style: TextStyle(color: Colors.redAccent, fontSize: 14, fontFamily: "Nunito-Bold")))),

    );
  }



  Widget adsListViewWidget() {
    return ListView.builder(
      itemCount: adsList.length,
     // reverse: true,
      shrinkWrap: true,
      // scrollDirection: Axis.horizontal,

      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child : InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdDetailsPage(id: adsList[index].id.toString())));
                  },
                child: Container(
                  margin: EdgeInsets.only(right: 10 , bottom: 5),
                  width: MediaQuery.of(context).size.width,


                  child: Card(
                    color: Colors.white,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                            child: adsList[index].photos !="" ?
                            Image.network(
                                'http://classified.ecodelinfotel.com/public/img/cmspage/'+adsList[index]!.photos!,
                                height: 130.0,
                                width: MediaQuery.of(context).size.width,
                                fit:BoxFit.cover
                            ):
                            Image.asset(
                              'assets/sample1.jpeg',
                              width: MediaQuery.of(context).size.width,
                              fit:BoxFit.cover,
                              height: 130,
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(

                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [

                                Text(adsList[index].title ?? '', style: TextStyle(color:HexColor("F1635D"),fontSize: 16, fontFamily: "Nunito-Bold")),

                                SizedBox(height: 3,),

                                // Row(
                                //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //
                                //     Container(
                                //         height:28,
                                //         width: 60,
                                //         decoration: BoxDecoration(
                                //           color: Colors.deepOrangeAccent,
                                //           borderRadius:BorderRadius.circular(
                                //               50.0),
                                //           boxShadow: [
                                //             BoxShadow(
                                //               color: Colors.grey.withOpacity(0.5),
                                //               spreadRadius: 1,
                                //               blurRadius: 7,
                                //               offset: Offset(0, 3), // changes position of shadow
                                //             ),
                                //           ],
                                //         ),
                                //         child: Center(
                                //           child:  Text('NEW', style: TextStyle( color : Colors.white, fontSize: 14, fontFamily: "Nunito-Regular")),
                                //         )
                                //     ),
                                //
                                //     SizedBox(width: 10,),
                                //
                                //     Container(
                                //         height:28,
                                //         width: 130,
                                //         decoration: BoxDecoration(
                                //           color: Colors.deepOrangeAccent,
                                //           borderRadius:BorderRadius.circular(
                                //               50.0),
                                //           boxShadow: [
                                //             BoxShadow(
                                //               color: Colors.grey.withOpacity(0.5),
                                //               spreadRadius: 1,
                                //               blurRadius: 7,
                                //               offset: Offset(0, 3), // changes position of shadow
                                //             ),
                                //           ],
                                //         ),
                                //         child: Center(
                                //           child:  Text('OPEN HOUSE', style: TextStyle( color : Colors.white, fontSize: 14, fontFamily: "Nunito-Regular")),
                                //         )
                                //     ),
                                //
                                //   ],
                                //
                                // ),

                                SizedBox(height: 5),

                                Text("Rs." + adsList[index].price.toString(), style: TextStyle(fontSize: 18, fontFamily: "Nunito-Bold")),

                                SizedBox(height: 5),

                                Text(
                                  getAddress(adsList[index]),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontFamily: 'Nunito-Bold',
                                    fontSize: 16,
                                  ),
                                ),

                                SizedBox(height: 5),

                                Row(
                                  children: [

                                    Text(
                                      "Open : ",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontFamily: 'Nunito-Bold',
                                        fontSize: 16,
                                      ),
                                    ),


                                    Text("SAT 1 - 4 pm", style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),

                                    SizedBox(width: 10),

                                  ],

                                ),


                                SizedBox(height: 5),


                                Row(

                                  children: [


                                    Image.asset(
                                      'assets/bed.png',
                                      width: 20,
                                      fit:BoxFit.cover,
                                      height: 20,
                                      color: Colors.black26,
                                    ),

                                    SizedBox(width: 3),

                                    Text(adsList[index].beds!=null ? adsList[index].beds.toString() : '', style: TextStyle(fontSize: 15, fontFamily: "Nunito-Bold")),

                                    SizedBox(width: 8),


                                    Image.asset(
                                      'assets/ic_bathroom.png',
                                      width: 15,
                                      fit:BoxFit.cover,
                                      height: 15,
                                      color: Colors.black26,

                                    ),

                                    SizedBox(width: 3),

                                    Text(adsList[index].bathroom!=null ? adsList[index].bathroom.toString() : '', style: TextStyle(fontSize: 15, fontFamily: "Nunito-Bold")),

                                    SizedBox(width: 8),

                                    Image.asset(
                                      'assets/ic_square.png',
                                      width: 15,
                                      fit:BoxFit.cover,
                                      height: 15,
                                      color: Colors.black26,
                                    ),

                                    SizedBox(width: 3),

                                    Text(adsList[index].space!=null ? adsList[index].space : '', style: TextStyle(fontSize: 15, fontFamily: "Nunito-Bold")),


                                  ],

                                )


                              ],
                            )
                        )

                      ],

                    ),

                  ),

                )
            )


        );
      },
    );
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






  /*
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

          ));
  }
*/

  Widget contentWidget() {
    return SingleChildScrollView(
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('All Ads', style: TextStyle(fontSize: 32, fontFamily: "Nunito-Bold")),

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

  String getAddress(Ads ad) {
    String? street = ad.strAddress!=null ? ad.strAddress : '';
    String? city = ad.citydata?.name!=null ? ad.citydata?.name : '';
    String? state = ad.statedata?.name!=null ? ad.statedata?.name : '';
    String? country = ad.countrydata?.name!=null ? ad.countrydata?.name : '';
    String? zipcode = ad.pincode!=null ? ad.pincode : '';

    String? st = street!.isNotEmpty ? street + ',' : '';
    String? ct = city!.isNotEmpty ? city + ',' : '';
    String? se = state!.isNotEmpty ? state + ',' : '';
    String? cn = country!.isNotEmpty ? country + ',' : '';
    String? zp = zipcode!.isNotEmpty ? zipcode + ',' : '';


    String? fullAddress = st+ct+se+cn+zp;

    return fullAddress;

  }

  void showFilterModelSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, SetState1)
          {
            return SingleChildScrollView(child:Container(
                height: 500,
                width: double.infinity,child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text('Filter', textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20,
                              color: Colors.red,
                              fontFamily: "Nunito-Bold")),
                      SizedBox(height: 5),
                      Divider(thickness: 1, color: Colors.red,),
                      SizedBox(height: 10),
                      Text('Category',
                          style: TextStyle(
                              fontSize: 16, fontFamily: "Nunito-Bold")),
                      SizedBox(height: 10),
                      Center(child: Container(
                          height: 50, child: ListView.builder(
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
                                SetState1(() {
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
                      ))),
                      SizedBox(height: 10),
                      Text('Price Range',
                          style: TextStyle(
                              fontSize: 16, fontFamily: "Nunito-Bold")),
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
                            min: _currentRangeValues.start,
                            max: _currentRangeValues.end,
                            divisions: 10,
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
                          Text(_currentRangeValues.start.round().toString(),
                              style: TextStyle(fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: "Nunito-Bold")),
                          Text(_currentRangeValues.end.round().toString(),
                              style: TextStyle(fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: "Nunito-Bold")),
                        ],),
                      SizedBox(height: 10),
                      Text('No.of Beds',
                          style: TextStyle(
                              fontSize: 16, fontFamily: "Nunito-Bold")),
                      SizedBox(height: 10),
                      Center(child: Container(
                          height: 50, child: ListView.builder(
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
                                SetState1(() {
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
                      ))),
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
                                        SetState1(() {
                                          selectedCategory = null;
                                          selectedCategoryId = 0;
                                          selectedBed = '';
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
                                       else{
                                          Navigator.pop(context);

                                         // filterResults(_currentRangeValues.start.round(), _currentRangeValues.end.round());

                                        }

                                      },
                                    ))),
                          ]),
                      SizedBox(height: 30),
                    ]))));
          });
          });
  }

  Widget categoriesListWidget() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      //controller: _controller,
      itemCount: categoriesList!.length,
      shrinkWrap: false,
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
                      borderRadius:BorderRadius.circular(2.0)
                  ),
                  child:Center(child: Text(categoriesList![index].title ?? '', style: TextStyle(fontSize: 16,color: selectedCategoryId == categoriesList![index].id ? Colors.white : Colors.red, fontFamily: "Nunito-Regular"))),

                )));
      },
    );
  }

  void filterResults(int startPrice, int endPrice) {

    for(int i=0;i<adsList.length;i++){
      if(adsList[i].category!=null && adsList[i].beds!=null){
        setState(() {
          filteredAdsList.add(adsList[i]);
        });
      }
    }
print(filteredAdsList.length);



    if (startPrice > 0 && endPrice > 0) {
      Set<Ads> searcherData = new Set<Ads>();
      Set<Ads> set = Set.from(filteredAdsList);

      set.forEach((Ads item) {
        print(item.category);
        if (item!.price! >= startPrice  && item!.price! <= endPrice && item.category == selectedCategoryId && item.beds == selectedBed) {
            searcherData.add(item);
        }
      });
      print(searcherData.length);
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

  void showToast(String msg)
  {
    Toast.show(msg, context);
    Timer(Duration(seconds: 3), () {
      Toast.dismiss();
    });
  }


}
