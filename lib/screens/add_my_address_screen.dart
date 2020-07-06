import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/models/my_addresses_model.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/my_addresses_screen.dart';

// ignore: must_be_immutable
class AddMyAddressScreen extends StatefulWidget {

  MyAddressesModel myAddressesModel;
  AddMyAddressScreen({Key key, this.myAddressesModel}) : super(key: key);
  @override
  AddMyAddressScreenState createState() => AddMyAddressScreenState(myAddressesModel);
}

class AddMyAddressScreenState extends State<AddMyAddressScreen>{

  bool status1 = false;
  String name;
  MyAddressesModel myAddressesModel;
  AddMyAddressScreenState(this.myAddressesModel);
  TextEditingController nameField = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameField.text = myAddressesModel.name;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 0, top: 50),
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                          ),
                        )
                    )
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              GestureDetector(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 50, right: 15),
                      child: Text(
                        'Удалить',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242)
                        ),
                      ),
                    )
                ),
                onTap: () async {
                    List<MyAddressesModel> list = await MyAddressesModel.getAddresses();
                    list.remove(myAddressesModel);
                    await MyAddressesModel.saveData();
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) {
                            return new MyAddressesScreen();
                          }
                      ),
                    );
                },
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 20),
              child: Text('Название',style: TextStyle(fontSize: 14, color: Color(0xFF9B9B9B))),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 30,
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child:TextField(
                  controller: nameField,
                ),
              ),
            )
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 20),
              child: Text(myAddressesModel.address,style: TextStyle(fontSize: 17, color: Color(0xFF424242))),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 20, bottom: 20),
              child: Text('г.Владикавказ, республика Северная Осетия-Алания, Россия',style: TextStyle(fontSize: 14, color: Color(0xFF9B9B9B))),
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 280),
            child: FlatButton(
              child: Text("Сохранить", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
              color: Color(0xFFFE534F),
              splashColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.only(left: 70, top: 20, right: 70, bottom: 20),
              onPressed: (){
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) {
                        myAddressesModel.type = MyAddressesType.home;
                        myAddressesModel.name = nameField.text;
                        MyAddressesModel.saveData();
                        return new MyAddressesScreen();
                      }
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}