import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContactInfoState();
  }
}

class ContactInfoState extends State<ContactInfo> {
  static final formKey = GlobalKey<FormState>();
  static TextEditingController name = new TextEditingController();
  static TextEditingController email = new TextEditingController();
  static TextEditingController phone = new TextEditingController();

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
              Text('Name \*', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                    controller: name,
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
              Text('Email \*', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                    controller: email,
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
              Text('Phone \*', style: TextStyle(fontSize: 16, fontFamily: "Nunito-Bold")),
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
                    controller: phone,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
        ))));
  }

}