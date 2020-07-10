

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:caodangvmu/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:http/http.dart' as http;
import 'package:caodangvmu/config/config.dart';
void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      primarySwatch: Colors.blue, // Your app THEME-COLOR
    ),
    home: new MyApp(),
  ));
}


class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => new _MyAppState();
}
class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Container(
      child: new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new AfterSplash(app:this),
        title: Text("Trường cao đẳng vimaru",style: TextStyle(fontFamily:'DancingScrip',color: Colors.blueAccent,fontWeight: FontWeight.bold,fontStyle:FontStyle.italic,fontSize: 40.0),),
        loadingText: Text("Đang tải dữ liệu", style: TextStyle(fontFamily:'DancingScripre',color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16.0)),
        image: new Image.asset("images/vmu.png"),
        gradientBackground: new LinearGradient(colors: [Colors.lightBlue, Colors.white60,Colors.white,Colors.lightBlue], begin: Alignment.topLeft, end: Alignment.bottomRight),

        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(fontSize: 16.0,fontWeight: FontWeight.w800),
        photoSize: 100.0,
        onClick: (){

        },
        loaderColor: Colors.redAccent,
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {


  var username= TextEditingController();
  var password=TextEditingController();
  final form_key= GlobalKey<FormState>();
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
    _MyAppState app;
  Map data;
  List result_arr;
  String user_name;
  String pass_word;
   AfterSplash({Key key, this.app}) : super(key: key);

  Future getdata(String msv ,String password,BuildContext context) async {

    try{


//      http.Response response = await  http.get("http://192.168.1.5:4432/caodangvmu/connectClient/login.php?msv=${msv}&password=${password}") ;

      http.Response response = await  http.post(Config.base_ip+"/caodangvmu/connectClient/login.php",
      body: <String,String>{
        "msv": "${msv}",
        "password":"${password}"
      }) ;

      data= json.decode(response.body);


        result_arr=data["data"] as List;

        if(result_arr.length>0)
          {
            String result= result_arr[0]["result"];
              int sum=int.tryParse(result);

              if(sum!=null)
                {

                  if(sum>0)
                    {
                      showDialog(context:context,builder: (context){
                        return new AlertDialog(
                            title: Container(alignment: Alignment.topCenter,child: Text("Thông báo",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.redAccent.withOpacity(0.8)),),),
                            content: ListTile(leading: Icon(Icons.check,color: Colors.greenAccent.withOpacity(0.8).withOpacity(0.8),size: 45,),title: Text("Đăng nhập thành công!",style: TextStyle(color: Colors.black,fontSize: 20),),)
                        );
                      });
                    Timer(Duration(milliseconds: 30000), (){

                    });
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Main_Screen(msv: msv,)));
                    }else
                      {
                        showDialog(context:context,builder: (context){
                          return new AlertDialog(
                              title: Container(alignment: Alignment.topCenter,child: Text("Thông báo",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.redAccent.withOpacity(0.8)),),),
                              content: ListTile(leading: Icon(Icons.error,color: Colors.redAccent.withOpacity(0.8),size: 45,),title: Text("Thông tin tài khoản hoặc mật khẩu không chính xác!",style: TextStyle(color: Colors.black,fontSize: 20),),)
                          );
                        });
                      }
                }else
                  {
                    showDialog(context:context,builder: (context){
                      return new AlertDialog(
                          title: Container(alignment: Alignment.topCenter,child: Text("Thông báo",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.redAccent.withOpacity(0.8)),),),
                          content: ListTile(leading: Icon(Icons.warning,color: Colors.yellow.withOpacity(0.8),size: 45,),title: Text("Có sự cố xảy ra khi đăng nhập!",style: TextStyle(color: Colors.black,fontSize: 20),),)
                      );
                    });
                  }
          }else
            {
              showDialog(context:context,builder: (context){
                return new AlertDialog(
                    title: Container(alignment: Alignment.topCenter,child: Text("Thông báo",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.redAccent.withOpacity(0.8)),),),
                    content: ListTile(leading: Icon(Icons.warning,color: Colors.yellow.withOpacity(0.8),size: 45,),title: Text("Có sự cố xảy ra khi đăng nhập!",style: TextStyle(color: Colors.black,fontSize: 20),),)
                );
              });
            }




    }catch(e)
    {
    print("lỗi:"+e.toString());
    }


  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new Stack(
        children: <Widget>[

          new Container(

            decoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage("images/boat.gif"), fit: BoxFit.cover,),


            ),

            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 150.0),
          ),

          Center(
            child:    ListView(
              children: <Widget>[

                Container(

                  alignment: Alignment.topCenter,


                  child: AvatarGlow(
                    startDelay: Duration(milliseconds: 500),
                    glowColor: Colors.white,
                    endRadius: 105.0,
                    duration: Duration(milliseconds: 1000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: Duration(milliseconds: 100),
                    child: Material(
                      elevation: 1.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor:Colors.grey[100] ,
                        child: Image.asset('images/vmu.png',),
                        radius: 60.0,

                      ),
                    ),
                    shape: BoxShape.circle,
                    animate: true,
                    curve: Curves.fastOutSlowIn,
                  ),



                ),


                Container(
                  alignment: Alignment.topCenter,



                  child: SizedBox(

                    child: ColorizeAnimatedTextKit(
                      onTap: () {

                      },
                      text: [

                        "Cao Đẳng Hàng Hải",
                      ],
                      textStyle: TextStyle(
                          fontSize: 45.0,
                          fontFamily: "DancingScrip"
                      ),
                      colors: [
                        Colors.blueAccent,
                        Colors.purple,
                        Colors.blue,
                        Colors.yellow,
                        Colors.white,
                        Colors.red,
                        Colors.green,

                      ],
                      textAlign: TextAlign.start,
                      alignment: AlignmentDirectional.topStart ,
                      totalRepeatCount: 2000,
                      isRepeatingAnimation: true,
                      onFinished: (){

                      },
                      speed: Duration(milliseconds: 450),
                      pause: Duration(seconds: 0),
                    ),
                  ),

                ),


                Container(
                  alignment: Alignment.center,
                  width: 350.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 12.0, 40.0,10.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(60.0),
                          color: Colors.white.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: EdgeInsets.all(1.0),

                            child: TextFormField(

                              controller: username,
                              decoration: InputDecoration(
                                hintText: "Msv",
                                icon: Icon(Icons.person,color: Colors.blueAccent,),
                                labelText: "Msv",
                                labelStyle: TextStyle(
                                    color: Colors.blueAccent,fontWeight: FontWeight.bold,
                                    fontSize: 16.0
                                ),
                                focusColor: Colors.red,


                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueAccent,width: 1,style: BorderStyle.solid),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red,width: 1,style: BorderStyle.solid),
                                ),

                              ),
                              cursorColor: Colors.red,
                              keyboardType: TextInputType.number,

                            ),


                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 12.0, 40.0, 10.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(60.0),
                          color: Colors.white.withOpacity(0.4),
                          elevation: 0.0,

                          child: Padding(

                            padding: EdgeInsets.all(1.0),

                            child: TextFormField(




                              controller: password,

                              decoration: InputDecoration(

                                hintText: "Pass word",
                                icon: Icon(Icons.lock_outline,color: Colors.blueAccent,),
                                labelText: "Pass word",

                                labelStyle: TextStyle(
                                    color: Colors.blueAccent,fontWeight: FontWeight.bold,
                                    fontSize: 16.0
                                ),
                                focusColor: Colors.red,

                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueAccent,width: 1,style: BorderStyle.solid),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red,width: 1,style: BorderStyle.solid),
                                ),

                              ),
                              cursorColor: Colors.red,

                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,

                            ),


                          ),
                        ),
                      )
                      ,

                      Padding(
                          padding: EdgeInsets.only(top: 40.0),


                          child: NiceButton(

                            radius: 40,
                            padding: const EdgeInsets.all(15),
                            text: "login",
                            fontSize: 25.0,

                            gradientColors: [secondColor,firstColor],
//                        gradientColors: [secondColor,Colors.white70,secondColor],

                            //      gradientColors: [Colors.white54,secondColor,Colors.white54],
                            onPressed: () {

                              if(username.text.trim().isEmpty|| password.text.isEmpty)
                                {
                                  showDialog(context: context,builder: (context){

                                    return new AlertDialog(
                                      title: Container(alignment: Alignment.topCenter,child: Text("Thông báo",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.redAccent.withOpacity(0.8)),),),
                                      content: ListTile(leading: Icon(Icons.warning,color: Colors.yellow.withOpacity(0.8),size: 45,),title: Text("Vui lòng điền đầy đủ thông tin!",style: TextStyle(color: Colors.black,fontSize: 20),),)
                                    );
                                  });

                                }else
                                  {

                                      getdata(username.text.trim(), password.text.trim(),context);
                                  }

                            },

                          )
                      )
                    ],
                  ),

                )

              ],
            ),
          )
        ],


      ),
    );
  }

}
