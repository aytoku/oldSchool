import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/Internet/check_internet.dart';
import 'package:food_delivery/PostData/auth_code_data_pass.dart';
import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/models/firebase_notification_handler.dart';
import 'package:food_delivery/screens/name_screen.dart';
import 'package:food_delivery/sideBar/side_bar.dart';
import 'package:food_delivery/test/api_test.dart';
import 'address_screen.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/food_list.dart';
import 'package:food_delivery/models/global_state.dart';
import 'package:food_delivery/models/modal_trigger.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/order_redister.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/scopped_model/main_model.dart';
import 'package:food_delivery/screens/add_card_screen.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/widgets/rating_starts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

import 'food_bottom_sheet_screen.dart';

class CodeScreen extends StatefulWidget {
  CodeScreen({Key key}) : super(key: key);

  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  TextField code1;
  TextField code2;
  TextField code3;
  TextField code4;
  String error = '';
  GlobalKey<ButtonState> buttonStateKey = new GlobalKey<ButtonState>();

  noConnection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
              height: 50,
              width: 100,
              child: Center(
                child: Text("Нет подключения к интернету"),
              ),
            ),
          ),
        );
      },
    );
  }

  void buttonColor() {
    String code = code1.controller.text +
        code2.controller.text +
        code3.controller.text +
        code4.controller.text;
    if (code.length > 0 &&
        buttonStateKey.currentState.color != Color(0xFFFE534F)) {
      buttonStateKey.currentState.setState(() {
        buttonStateKey.currentState.color = Color(0xFFFE534F);
      });
    } else if (code.length == 0 &&
        buttonStateKey.currentState.color != Color(0xFFF3F3F3)) {
      buttonStateKey.currentState.setState(() {
        buttonStateKey.currentState.color = Color(0xFFF3F3F3);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: FutureBuilder<AuthData>(
          future:
              loadAuthData(necessaryDataForAuth.device_id, currentUser.phone),
          builder: (BuildContext context, AsyncSnapshot<AuthData> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  InkWell(
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: EdgeInsets.only(right: 15, top: 30),
                                child: Container(
                                  width: 40,
                                  height: 60,
                                  child: Center(
                                    child: SvgPicture.asset(
                                        'assets/svg_images/code_cross.svg'),
                                  ),
                                ))),
                      ],
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 40),
                        child: Text('Введите код из смс',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: 180,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 0, left: 0, bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 7, right: 7),
                                        child: code1 = TextField(
                                            autofocus: true,
                                            focusNode: new FocusNode(),
                                            controller:
                                                new TextEditingController(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 28),
                                            keyboardType: TextInputType.phone,
                                            maxLength: 1,
                                            decoration: new InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFFD6F6D)),
                                              ),
                                              counterText: '',
                                            ),
                                            onChanged: (String value) {
                                              if (value != '') {
                                                code2.focusNode.requestFocus();
                                              }
                                              buttonColor();
                                            }),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 7, right: 7),
                                        child: code2 = TextField(
                                            focusNode: new FocusNode(),
                                            controller:
                                                new TextEditingController(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 28),
                                            keyboardType: TextInputType.phone,
                                            maxLength: 1,
                                            decoration: new InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFFD6F6D)),
                                              ),
                                              counterText: '',
                                            ),
                                            onChanged: (String value) {
                                              if (value != '') {
                                                code3.focusNode.requestFocus();
                                              }
                                              if(value.isEmpty){
                                                code1.focusNode.requestFocus();
                                              }
                                              buttonColor();
                                            }),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 7, right: 7),
                                        child: code3 = TextField(
                                            focusNode: new FocusNode(),
                                            controller:
                                                new TextEditingController(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 28),
                                            keyboardType: TextInputType.phone,
                                            maxLength: 1,
                                            decoration: new InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFFD6F6D)),
                                              ),
                                              counterText: '',
                                            ),
                                            onChanged: (String value) {
                                              if (value != '') {
                                                code4.focusNode.requestFocus();
                                              }
                                              if(value.isEmpty){
                                                code2.focusNode.requestFocus();
                                              }
                                              buttonColor();
                                            }),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 7, right: 7),
                                        child: code4 = TextField(
                                          onChanged: (String value){
                                            if(value.isEmpty){
                                              code3.focusNode.requestFocus();
                                            }
                                          },
                                          focusNode: new FocusNode(),
                                          controller:
                                              new TextEditingController(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 28),
                                          keyboardType: TextInputType.phone,
                                          maxLength: 1,
                                          decoration: new InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFFD6F6D)),
                                            ),
                                            counterText: '',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 0,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 0, left: 0),
                                child: Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 0, top: 15),
                              child: new TimerCountDown(codeScreenState: this),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 20, left: 0, right: 0, top: 10),
                              child: Button(
                                key: buttonStateKey,
                                color: Color(0xFFF3F3F3),
                                onTap: () async {
                                  if (await Internet.checkConnection()) {
                                    String temp = '';
                                    temp = code1.controller.text +
                                        code2.controller.text +
                                        code3.controller.text +
                                        code4.controller.text;
                                    authCodeData = await loadAuthCodeData(
                                        necessaryDataForAuth.device_id,
                                        int.parse(temp));
                                    if (authCodeData != null) {
                                      necessaryDataForAuth.phone_number =
                                          currentUser.phone;
                                      necessaryDataForAuth.refresh_token =
                                          authCodeData.refresh_token;
                                      NecessaryDataForAuth.saveData();
                                      if(necessaryDataForAuth.name == ''){
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                            builder: (context) =>
                                            new NameScreen(),
                                          ),
                                        );
                                      }
                                      else{
                                        homeScreenKey =
                                        new GlobalKey<HomeScreenState>();
                                        await new FirebaseNotifications()
                                            .setUpFirebase();
                                        currentUser.isLoggedIn = true;
                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) => HomeScreen()),
                                                (Route<dynamic> route) => false);
                                      }

                                    } else {
                                      setState(() {
                                        error = 'Вы ввели неверный смс код';
                                      });
                                    }
                                  } else {
                                    noConnection(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class TimerCountDown extends StatefulWidget {
  TimerCountDown({
    Key key,
    this.codeScreenState,
  }) : super(key: key);
  final _CodeScreenState codeScreenState;

  @override
  TimerCountDownState createState() {
    return new TimerCountDownState(codeScreenState: codeScreenState);
  }
}

class TimerCountDownState extends State<TimerCountDown> {
  TimerCountDownState({this.codeScreenState});

  final _CodeScreenState codeScreenState;
  Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            _timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_start == 60) {
      startTimer();
    }
    return _start != 0
        ? Center(
            child: Text('Получить новый код можно через $_start c',
                style: TextStyle(
                  color: Color(0x97979797),
                  fontSize: 13.0,
                  letterSpacing: 1.2,
                )),
          )
        : GestureDetector(
            child: Text(
              'Отпарвить код повторно',
              style: TextStyle(),
            ),
            onTap: () {
              codeScreenState.setState(() {});
            },
          );
  }
}

class Button extends StatefulWidget {
  Color color;
  final AsyncCallback onTap;

  Button({Key key, this.color, this.onTap}) : super(key: key);

  @override
  ButtonState createState() {
    return new ButtonState(color, onTap);
  }
}

class ButtonState extends State<Button> {
  String error = '';
  TextField code1;
  TextField code2;
  TextField code3;
  TextField code4;
  Color color;
  final AsyncCallback onTap;

  ButtonState(this.color, this.onTap);

  noConnection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
              height: 50,
              width: 100,
              child: Center(
                child: Text("Нет подключения к интернету"),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    if(){
//
//    }
    return FlatButton(
      child: Text('Далее',
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.white)),
      color: color,
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.only(left: 120, top: 20, right: 120, bottom: 20),
      onPressed: () async {
        if (await Internet.checkConnection()) {
          await onTap();
        } else {
          noConnection(context);
        }
      },
    );
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+]?7)[0-9]{10}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Укажите норер';
    } else if (!regExp.hasMatch(value)) {
      return 'Указан неверный номер';
    }
    return null;
  }
}
