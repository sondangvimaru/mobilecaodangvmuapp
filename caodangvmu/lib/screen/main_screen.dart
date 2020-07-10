import 'dart:convert';

import 'package:caodangvmu/config/config.dart';
import 'package:caodangvmu/pages/Home.dart';
import 'package:caodangvmu/pages/dangky_page.dart';
import 'package:caodangvmu/pages/diem_page.dart';
import 'package:caodangvmu/pages/lichthi_page.dart';
import 'package:caodangvmu/pages/tkb_page.dart';
import 'package:caodangvmu/pages/user.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:caodangvmu/pages/Notifications.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class Main_Screen extends StatefulWidget {


  final msv;


  const Main_Screen({Key key, this.msv}) : super(key: key);

  @override
  _Main_ScreenState createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  int current_page=0;

  String badge='99';

  var controlner;
  Map data;
  List result_arr;
  String ten=" ";
  String lhc=" ";
  String image=" ";
  Future getdata(String msv) async {
    try {
      http.Response response = await http.get(
          Config.base_ip+"/caodangvmu/connectClient/getsv.php?msv=${msv}");


      data = json.decode(response.body);


      result_arr = data["data"] as List;
      setState(() {

        ten=result_arr[0]["ten"];
        lhc=result_arr[0]["malophanhchinh"];
        image=result_arr[0]["anh_dai_dien"];

      });

    }
    catch(e)
    {

    }


  }

  hexcolor(String color)
  {
    String colornew="0xff"+color;
    colornew=colornew.replaceAll("#", '');
    int colorint=int.parse(colornew);
    return colorint;
  }

  _launchURL(String url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  void initState() {
   getdata(widget.msv);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent ));

    final pages=[HomePage(),Notifications(msv:widget.msv),User_page(msv:widget.msv)];


    return WillPopScope(
      onWillPop: (){
        return new Future(()=> false);
      },
      child: Scaffold(


        body: Container(child: pages[current_page]),
          bottomNavigationBar:   ConvexAppBar.badge({1:badge},
          color: Colors.white
          ,
              gradient: LinearGradient(colors: [Color(hexcolor("##43cea2")),Color(hexcolor("#185a9d"))]),


              items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.notifications, title: 'Notifications'),
              TabItem(icon: Icons.person_outline, title: 'User'),
            ],
               controller: controlner,
            onTap: (index) {
            setState(() {
              current_page=index;
              badge='44';
            });
            },

          ),
          drawer:  Drawer(

            child: ListView(


            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: UserAccountsDrawerHeader(arrowColor:Colors.red,accountName: Text("Họ tên:"+ten,style: TextStyle(color: Colors.white,fontSize: 20)),

                  accountEmail: Text("Lớp:"+lhc,style: TextStyle(color: Colors.white,fontSize: 20,fontStyle: FontStyle.italic),),currentAccountPicture: GestureDetector(child: CircleAvatar(

                    backgroundColor: Colors.white,
                    child:CircularProfileAvatar(
                      null,
                      child: InkWell(

                          onTap: (){

                          },

                          child: Image.network(Config.base_ip+"/caodangvmu/images/${image}")),
                    borderColor: Colors.white70,
                      borderWidth: 3,

                      radius: 80,

                    ),

                  ),

                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dangky_page(data: result_arr,)));
                },
                child: ListTile(
                  title:Text("Đăng ký học") ,
                  leading: Icon(Icons.home,color: Colors.blue,),
                ),
              ),
              InkWell(
                onTap: (){

                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>tkb_page(msv: result_arr[0]["msv"],)));

                },
                child: ListTile(
                  title:Text("Thời khóa biểu") ,
                  leading: Icon(IconData(0xf0ce, fontFamily: "fonttkb"),color: Colors.blue,),
                ),
              )
              ,
              InkWell(
                onTap: (){

                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>lichthi_page(msv: result_arr[0]["msv"],)));

                },
                child: ListTile(
                  title:Text("Lịch Thi") ,
                  leading: Icon(Icons.shopping_basket,color: Colors.blue,),
                ),
              )
              ,

              InkWell(
                onTap: (){

               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Diem_page( msv: result_arr[0]["msv"])));




                },
                child: ListTile(
                  title:Text("Điểm") ,
                  leading: Icon(Icons.shopping_cart,color: Colors.blue,),
                ),
              ),
              InkWell(
                onTap: (){

                  showDialog(context: context,builder: (context){
                    return new AlertDialog(
                      title: Text("Thông báo",style: TextStyle(fontSize: 20,color: Colors.red),),
                      content: Text("Bạn có chắc chắn muốn đăng xuất?"),
                      actions: <Widget>[

                        MaterialButton(
                          onPressed: ()
                          {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyApp()));

                          },
                          child: Text("có"),
                        ),

                        MaterialButton(
                          onPressed: ()
                          {

                            Navigator.of(context).pop(context);

                          },
                          child: Text("không"),
                        )
                      ],

                    );
                  });
                },
                child: ListTile(
                  title:Text("Đăng xuất") ,
                  leading: Icon(IconData(0xe800, fontFamily: "_kFontFam"),color: Colors.blue,),
                ),
              )
              ,

            ],

          ),),
      ),
    );
  }
}
