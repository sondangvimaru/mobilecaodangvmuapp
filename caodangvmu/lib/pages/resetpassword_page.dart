import 'dart:async';
import 'dart:convert';

import 'package:caodangvmu/animation/wave_animation.dart';
import 'package:caodangvmu/background/wave_background.dart';
import 'package:caodangvmu/config/config.dart';
import 'package:caodangvmu/main.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:nice_button/NiceButton.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
class ResetPage extends StatelessWidget {
String msv;

  ResetPage({Key key, this.msv}) : super(key: key);
Timer timer;


void startTimer() {
  // Start the periodic timer which prints something every 1 seconds
  timer=  new Timer.periodic(new Duration(seconds: 3), (time) {


  });
}
  hexcolor(String color)
  {
    String colornew="0xff"+color;
    colornew=colornew.replaceAll("#", '');
    int colorint=int.parse(colornew);
    return colorint;
  }
  Map data;
  List result_arr= new List();
  TextEditingController old_password_controller =TextEditingController();
  TextEditingController new_pass_word_controller=TextEditingController();
  TextEditingController comfirm_pass_word_controller=TextEditingController();
  Future doimk(String msv ,String old_password, new_pass_word ,BuildContext context) async {

    try{


//      http.Response response = await  http.get("http://192.168.1.5:4432/caodangvmu/connectClient/login.php?msv=${msv}&password=${password}") ;

      http.Response response = await  http.post(Config.base_ip+"/caodangvmu/connectClient/doimk.php",
          body: <String,String>{
            "msv": "${msv}",
            "old_pass":"${old_password}",
            "newpassword":"${new_pass_word}"
          }) ;
      data= json.decode(response.body);


      result_arr=data["data"] as List;




        showDialog(context:context,builder: (context){
          return new AlertDialog(
              title: Container(alignment: Alignment.topCenter,child: Text("Thông báo",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.redAccent.withOpacity(0.8)),),),
              content: ListTile(leading: Icon(Icons.info_outline,color: Colors.blueAccent.withOpacity(0.8),size: 45,),title: Text(result_arr[0]["result"],style: TextStyle(color: Colors.black,fontSize: 20),),)
          );

        });

      startTimer();
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyApp()));


    }catch(e)
    {
      print("lỗi:"+e.toString());
    }


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Đặt lại mật khẩu",style: TextStyle(color: Colors.white,fontSize: 20),),

      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: wave_background()),
          onBottom(Wave_animation(
            height: 180,
            speed: 1.0,
          )),
          onBottom(Wave_animation(
            height: 120,
            speed: 0.9,
            offset: pi,
          )),
          onBottom(Wave_animation(
            height: 220,
            speed: 1.5,
            offset: pi / 2,
          )),
          Positioned.fill(child: Center(
            child: Container(
              height: 550,
              child: ListView(

                children: <Widget>[


   Padding(padding: EdgeInsets.only(top: 10.0),)
      , Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(

      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.2),
        elevation: 0.0,
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
      controller: old_password_controller,
      decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 3.0)),
      hintText:"Old Password",
      labelText: "Old Password",
                  ),
                ),
              ),
        ),
      ),
                  Padding(padding: EdgeInsets.only(top: 10.0),)
                  , Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(

                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.2),
                        elevation: 0.0,
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        controller: new_pass_word_controller,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueAccent, width: 3.0)),
                              hintText:" New Password",
                              labelText: "New Password",
                          ),
                        ),
                      ),
                    ),
                  ),   Padding(padding: EdgeInsets.only(top: 10.0),)
                  , Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(

                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.2),
                        elevation: 0.0,
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          controller: comfirm_pass_word_controller,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueAccent, width: 3.0)),
                              hintText:"Confirm Password",
                              labelText: "Confirm Password",
                          ),
                        ),
                      ),
                    ),
                  ),
                        Padding(
                        padding: EdgeInsets.only(top: 20.0),
    child: NiceButton(

    radius: 40,
    padding: const EdgeInsets.all(15),
    text: "Đặt Lại",
    fontSize: 25.0,

    gradientColors: [Colors.white60.withOpacity(0.4),Colors.blueAccent.withOpacity(0.8)],
//                        gradientColors: [secondColor,Colors.white70,secondColor],

    //      gradientColors: [Colors.white54,secondColor,Colors.white54],
    onPressed: () {
      if(new_pass_word_controller.text.trim().isEmpty || comfirm_pass_word_controller.text.trim().isEmpty || old_password_controller.text.trim().isEmpty)
        {
Toast.show("Vui lòng nhập đầy đủ thông tin", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
        }
      else
        {
          if(new_pass_word_controller.text.trim()!=comfirm_pass_word_controller.text.trim())
            {
              Toast.show("Mật khẩu mới và mật khẩu xác nhận phải trùng khớp", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);

            }else
              {
                doimk(msv, old_password_controller.text.trim(),new_pass_word_controller.text.trim(), context);
              }
        }

    }, background: Colors.white60,

    ))
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  onBottom(Widget child) => Positioned.fill(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );
}