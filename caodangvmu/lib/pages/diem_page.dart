import 'dart:async';
import 'dart:convert';

import 'package:caodangvmu/animation/ListviewEffect.dart';
import 'package:caodangvmu/config/config.dart';
import 'package:caodangvmu/pages/Home.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 

class Diem_page extends StatefulWidget {
  final msv;
  
  const Diem_page({Key key, this.msv}) : super(key: key);
 
  @override
  _Diem_pageState createState() => _Diem_pageState( );
}

class _Diem_pageState extends State<Diem_page> {
   


List <String> data = new List();
Map dataj,datad;
List dotdk_list = new List();
List diemlist= new List();
Future getdata(String msv) async {
  try {
    http.Response response = await http.get(
        Config.base_ip+"/caodangvmu/connectClient/getdotdkbysv.php?msv=${msv}");


    dataj = json.decode(response.body);


  
    setState(() {
      dotdk_list = dataj["data"] as List;
      
      for(var item in dotdk_list)
        {
          data.add(item["name"]);
        }

    });

  }
  catch(e)
  {

  }


}
Future getlistdiem(String msv,String dotdk_id) async {
  try {
    http.Response response = await http.get(
        Config.base_ip+"/caodangvmu/connectClient/getdiem.php?msv=${msv}&dotdk_id=${dotdk_id}");


    datad = json.decode(response.body);


    
    setState(() {
      diemlist= new List();
      diemlist= datad["data"] as List;

      

    });

  }
  catch(e)
  {

  }


}
//Widget  item_list(dynamic item,){
//  return List_item(
//    tenhp: diemlist[index]["tenhocphan"],
//    mahocphan: diemlist[index]["mahocphan"],
//    diemX: diemlist[index]["diemX"],
//    diemY: diemlist[index]["diemY"],
//    diemZ: diemlist[index]["diemZ"],
//    diemchu: diemlist[index]["diemchu"],
//    diemso: diemlist[index]["diemso"],
//    ghichu: diemlist[index]["ghichu"],
//  );
//}
  Widget  item_list(dynamic item,){
  return List_item(
    tenhp: item["tenhocphan"],
    mahocphan:  item["mahocphan"],
    diemX: item["diemX"],
    diemY:  item["diemY"],
    diemZ:  item["diemZ"],
    diemchu: item["diemchu"],
    diemso: item["diemso"],
    ghichu: item["ghichu"],
  );
}
Duration _duration = Duration(milliseconds: 300);
@override
  void initState() {
     getdata(widget.msv);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


 
    return Scaffold(
      appBar: AppBar(
        title: Text("Bảng điểm",style: TextStyle(color: Colors.white,fontSize: 20),),

      ),
      body:  Padding(
        padding: const EdgeInsets.all(5.0),
        child:  ListTile(

          title:  DropDownField(

            textStyle: TextStyle(fontFamily: "DancingScripre",fontSize: 20,fontWeight: FontWeight.bold),
            required: false,
            hintText: 'Đợt Đăng ký',
            labelText: 'Đợt Đăng ký',

            items: data,
            strict: true,

            onValueChanged: (value) => {
              this.setState(() {

                for(int i=0;i<dotdk_list.length;i++)
                {
                  if(dotdk_list[i]["name"].toString().toLowerCase()==value.toString().toLowerCase())
                  {

                    getlistdiem(widget.msv,dotdk_list[i]["dotdk_id"]);

                  }
                }
              })
            },
          ),
            subtitle:  new  ListViewEffect(duration: _duration, children: diemlist.map((item) =>  item_list(item)).toList()),
        ),
        )





      );





  }
}


class List_item extends StatelessWidget {

   final tenhp;
   final mahocphan;
    final diemX;
    final diemY;
    final diemZ;
    final diemchu;
    final diemso;
    final ghichu;

  const List_item({Key key, this.tenhp, this.mahocphan, this.diemX, this.diemY, this.diemZ, this.diemchu, this.diemso, this.ghichu}) : super(key: key);

  String isnull( String value)
  {
    if(value==null)
      return " ";
    return value;
    
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent.withOpacity(0.6),
        shape: StadiumBorder(
        side: BorderSide(
        color: Colors.redAccent.withOpacity(0.6),
        width: 2.0,
    )),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text("Học phần : "+tenhp,style: TextStyle(fontFamily: "DancingScripre",color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text("Mã học phần : "+mahocphan,style: TextStyle(fontFamily: "DancingScripre",color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text("Điểm X : "+isnull(diemX),style: TextStyle(fontFamily: "DancingScripre",color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text("Điểm Y : "+isnull(diemY),style: TextStyle(fontFamily: "DancingScripre",color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text("Điểm Z : "+isnull(diemZ),style: TextStyle(fontFamily: "DancingScripre",color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text("Điểm chữ : "+diemchu,style: TextStyle(fontFamily: "DancingScripre",color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text("Thang điểm 4 : "+diemso,style: TextStyle(fontFamily: "DancingScripre",color:Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text("Ghi chú : ",style: TextStyle(fontFamily: "DancingScripre",color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(isnull(ghichu),style: TextStyle(fontFamily: "DancingScripre",color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
            ),
          ],
        ),

    );
  }
}
