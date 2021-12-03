import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rent_app/allads.dart';
import 'package:rent_app/home.dart';
import 'package:rent_app/login.dart';
import 'package:rent_app/myads.dart';
import 'package:rent_app/myprofile.dart';
import 'package:rent_app/newsearchpage.dart';
import 'package:rent_app/postad.dart';
import 'package:rent_app/utils/class_builders.dart';
import 'package:rent_app/utils/kf_drawer.dart';
import 'package:rent_app/utils/preferences.dart';

import 'searchpage.dart';

Future<void> main() async {
  ClassBuilder.registerClasses();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  String? name;
  String? email;
  MainScreen({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  KFDrawerController? _drawerController;


  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: AllAdsPage(),
      items: [
        KFDrawerItem.initWithPage(
          text: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),child:Text('Home', style: TextStyle(color: Colors.white,fontSize: 18, fontFamily: "Nunito-Regular"))),
          icon: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),child: SvgPicture.asset('assets/icon_home.svg', semanticsLabel: 'Home')),
          page: AllAdsPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),child:Text('Post Ad', style: TextStyle(color: Colors.white,fontSize: 18, fontFamily: "Nunito-Regular"))),
          icon: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),child: SvgPicture.asset('assets/postad.svg', semanticsLabel: 'Post Ad')),
          page: TestPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),child:Text('My Ads', style: TextStyle(color: Colors.white,fontSize: 18, fontFamily: "Nunito-Regular"))),
          icon: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),child:SvgPicture.asset('assets/icon_saved.svg', semanticsLabel: 'Save')),
          page: MyAdsPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),child:Text('Search', style: TextStyle(color: Colors.white,fontSize: 18, fontFamily: "Nunito-Regular"))),
          icon: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),child:SvgPicture.asset('assets/icon_search.svg', semanticsLabel: 'Search')),
          page: NewSearchPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),child:Text('Save', style: TextStyle(color: Colors.white,fontSize: 18, fontFamily: "Nunito-Regular"))),
          icon: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),child:SvgPicture.asset('assets/icon_saved.svg', semanticsLabel: 'Save')),
          page: TestPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),child:Text('Alerts', style: TextStyle(color: Colors.white,fontSize: 18, fontFamily: "Nunito-Regular"))),
          icon: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),child:SvgPicture.asset('assets/icon_alerts.svg', semanticsLabel: 'Alerts')),
          page: SearchPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),child:Text('Profile', style: TextStyle(color: Colors.white,fontSize: 18, fontFamily: "Nunito-Regular"))),
          icon: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),child:SvgPicture.asset('assets/icon_profile.svg', semanticsLabel: 'Profile')),
          page: MyProfilePage(),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),child:Text('Setting', style: TextStyle(color: Colors.white,fontSize: 18, fontFamily: "Nunito-Regular"))),
          icon: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),child:SvgPicture.asset('assets/icon_setting.svg', semanticsLabel: 'Setting')),
          page: TestPage(),
        ),
      ],
    );
  }
  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
      final timegap = DateTime.now().difference(pre_backpress);
      final cantExit = timegap >= Duration(seconds: 2);
      pre_backpress = DateTime.now();
      if(cantExit){
        //show snackbar
        final snack = SnackBar(content: Text('Press Back button again to Exit'),duration: Duration(seconds: 2),);
        ScaffoldMessenger.of(context).showSnackBar(snack);
        return false;
      }else{
        return true;
      }
    },


    child:
      Scaffold(
      body: KFDrawer(
//        borderRadius: 0.0,
//        shadowBorderRadius: 0.0,
//        menuPadding: EdgeInsets.all(0.0),
//        scrollable: true,
        controller: _drawerController,
        header: Align(
          alignment: Alignment.topLeft,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
            child:  InkWell(onTap: (){
              _drawerController!.close!();
            },
                child: SvgPicture.asset('assets/icon_close.svg', semanticsLabel: 'Close'))),

            Container(
              padding: const EdgeInsets.fromLTRB(24, 12, 12, 0),
              // width: MediaQuery.of(context).size.width * 0.6,
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                        width: 36.0,
                        height: 36.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor('EEEEEF'),
                            image: new DecorationImage(
                              fit: Preference?.getString('profileImg')!.isNotEmpty ? BoxFit.fill : BoxFit.none,
                              // image: Preference?.getString('profileImg')!.isNotEmpty ?
                              // new NetworkImage(Preference.getString('imgUrl')+Preference?.getString('profileImg') ?? '') :
                              // new AssetImage("assets/add_pic.png"),
                              image:  new NetworkImage(Preference?.getString('imgUrl') ?? '')
                            )
                        )),
                    Padding(padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
                        child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(Preference.getString('name') ?? '', style: TextStyle(fontSize: 18, fontFamily: "Nunito-Bold", color: Colors.white)),
                              SizedBox(height: 3),
                              Text(Preference.getString('email') ?? '', style: TextStyle(fontSize: 12, fontFamily: "Nunito-Regular", color: Colors.white)),

                            ]))
                  ]),
            ),
          ],

        )),

        footer: KFDrawerItem(
          text:Padding(padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),child:Text('Sign out', style: TextStyle(color: Colors.white,fontSize: 18, fontFamily: "Nunito-Regular"))),
          icon: Padding(padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),child:SvgPicture.asset('assets/icon_signout.svg', semanticsLabel: 'Sign out')),
          onPressed: () {

            String provider = Preference.getString("provider") ?? '';
            if(provider.isNotEmpty){
              if(provider == "google"){
                GoogleSignIn _googleSignIn = GoogleSignIn();
                _googleSignIn.signOut().then((value) {
                  setState(() {
                    clearData();
                    Navigator.pushAndRemoveUntil<dynamic>(context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                          (route) => false,//if you want to disable back feature set to false
                    );                  });
                });
              }
              else if(provider == "facebook"){
                FacebookAuth.instance.logOut().then((value) {
                  setState(() {
                    clearData();
                    Navigator.pushAndRemoveUntil<dynamic>(context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                          (route) => false,//if you want to disable back feature set to false
                    );
                  });
                });
              }
              else{
                clearData();
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => LoginPage(),
                  ),
                      (route) => false,//if you want to disable back feature set to false
                );
              }

            }

            Navigator.of(context).push(CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return LoginPage();
              },
            ));
          },
        ),
        decoration: BoxDecoration(
          color: HexColor('4F3592'),
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [Color.fromRGBO(79, 53, 146, 100.0),Color.fromRGBO(123, 104, 174, 100.0)],
          //   tileMode: TileMode.repeated,
          // ),
        ),
      ),
    ));
  }

  void clearData() {
    Preference.setString("avatar", "");
    Preference.setString("provider", "");
    Preference.setString("name", "");
    Preference.setString("email", "");
  }
}