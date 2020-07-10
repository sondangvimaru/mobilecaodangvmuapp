import 'dart:convert';

import 'package:caodangvmu/animation/wave_animation.dart';
import 'package:caodangvmu/config/config.dart';
import 'package:caodangvmu/pages/Notification_Detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:math';
class Notifications extends StatefulWidget {
  final msv;

  const Notifications({Key key, this.msv}) : super(key: key);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  Map data;
  List result_arr= new List();
  Future getdata(String msv) async {
    try {

      http.Response response = await http.get(
          Config.base_ip+"/caodangvmu/connectClient/thongbao.php?msv=${msv}");


      data = json.decode(response.body);


     setState(() {
       result_arr = data["data"] as List;
     });


    }
    catch(e)
    {

    }


  }
  @override
  void initState() {
    getdata(widget.msv);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.blueGrey.withOpacity(0.2),
      body: Stack(
        children: <Widget>[

          onBottom(Wave_animation(
            height: 140,
            speed: 1.0,
          )),
          onBottom(Wave_animation(
            height: 80,
            speed: 0.9,
            offset: pi,
          )),
          onBottom(Wave_animation(
            height: 180,
            speed: 1.5,
            offset: pi / 2,
          )),
          ListView.builder(itemCount: result_arr.length,itemBuilder: (context,index){

            return list_items(

              notification: result_arr[index],

            );


          },),
        ],
      ),
    );
  }
}

class list_items extends StatelessWidget {

final notification;

  const list_items({Key key, this.notification}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Notification_detail(nofications: notification,)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 3.0, 15.0,0.0),
        child: Card(
          color: Colors.lightBlue.withOpacity(0.8),
          child:

            Padding(

              padding: const EdgeInsets.all(8.0),
              child: Text(notification["tieude"],style: TextStyle(fontFamily: "DancingScrip",color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold),),
            ),

        ),
      ),
    );
  }
}

onBottom(Widget child) => Positioned.fill(
  child: Align(
    alignment: Alignment.bottomCenter,
    child: child,
  ),
);