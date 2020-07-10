import 'dart:convert';

import 'package:caodangvmu/animation/SnapList.dart';
import 'package:caodangvmu/animation/timeline_list.dart';
import 'package:caodangvmu/config/config.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> urls = new List<String>();

  Map data;
  List result_arr= new List();
  String limit=" ";
  Future getdata(String arr,String limit) async {
    try {
      http.Response response = await http.get(
          Config.base_ip+"/caodangvmu/connectClient/baidang.php?arr=${arr.trim()}&limit=${limit}");

print(  Config.base_ip+"/caodangvmu/connectClient/baidang.php?arr=${arr.trim()}&limit=${limit}");
      data = json.decode(response.body);


    setState(() {
      result_arr = data["data"] as List;
    });

    }
    catch(e)
    {

      print("Lỗi");
    }


  }
  Future<void> isset() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str=" ";
    if(prefs.containsKey("list_dm"))
    {

      List dm= prefs.getStringList("list_dm");


      dm.forEach((element) {

        str+=element+",";
      });


      }

    if(prefs.containsKey("limit_news"))
    {
      limit=prefs.getString("limit_news");


    }
    getdata(str,limit);


  }
  int currentPage=0;
  @override
  void initState() {
    isset();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.lightBlue.withOpacity(0.2)));
     Widget image_slide = new Container(
      height: 200.0,
      child: Carousel(
          boxFit: BoxFit.cover,
          images:[

            AssetImage('images/slide1.jpg'),
            AssetImage('images/slide2.jpg'),
            AssetImage('images/slide3.jpg'),
            AssetImage('images/slide4.jpg'),
            AssetImage('images/slide5.jpg'),

          ],
          autoplay: true,
          dotSize: 6.0,
          indicatorBgPadding: 3.0,
          dotColor: Colors.blue,
          dotIncreasedColor: Colors.white,
          dotBgColor: Colors.transparent,
          animationCurve: Curves.linearToEaseOut,
          animationDuration: Duration(milliseconds: 1000)
      ),

    );
    return Scaffold(




    body: ListView(
      children: <Widget>[

            image_slide,
          Padding(padding: EdgeInsets.only(top: 20),),
        Align(
          alignment: Alignment.center,
          child:   Text("Tin tức",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(height: 6,color: Colors.blue.withOpacity(0.5),),
          ),
          SingleChildScrollView(
            child: Container(
              height: 350,
              child: HorizontalTab(
                baidang: result_arr,loadMore: _loadMoreItems,
              )
            ),
          )



    ],

    ),

    );

  }
  void _loadMoreItems() {
    setState(() {
      result_arr = new List.from(result_arr)..addAll(result_arr);
    });
  }

}
class item extends StatelessWidget {
  int index;

   item({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Card(
        child: Hero(
          tag: "tag ${index}",
          child: Material(
            child: Text("index"),
          ),
        ),
      ),
    );
  }
}


