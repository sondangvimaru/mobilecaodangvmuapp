
import 'dart:convert';

import 'package:caodangvmu/config/config.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class Dangky_page extends StatefulWidget {
  final data;

  const Dangky_page({Key key, this.data}) : super(key: key);

  @override
  _Dangky_pageState createState() => _Dangky_pageState();
}


List list_result= new List();
List dadk= new List();
class _Dangky_pageState extends State<Dangky_page> with SingleTickerProviderStateMixin {

  Map<String, dynamic> formData;
  List<String> classre = new List();
  String hocky=" ";
  List<String>filter(List data)
  {
    List<String> result= new List();
    List<String> tmp= new List();
    for(int i=0;i<data.length;i++)
      {
        tmp.add(data[i]["tenhocphan"]);
      }
    for (var i = 0; i < tmp.length; i++) {
      bool repeated = false;
      for (var j = 0; j < result.length; j++) {
        if (tmp[i] == result[j]) {
          repeated = true;
        }
      }
      if (!repeated) {
        result.add(tmp[i]);
      }
    }
    return result;
  }
  Map datalhp;
  List result_arr;
  Future getdata(String manganh) async {
    try {
      http.Response response = await http.get(
          Config.base_ip+"/caodangvmu/connectClient/getlophocphan.php?manganh=${manganh}");


      datalhp = json.decode(response.body);


      result_arr = datalhp["data"] as List;


      setState(() {

        hocky=result_arr[0]["name"];

        classre=filter(result_arr);
        getdsdangky(widget.data[0]["msv"],this,result_arr);
      });

    }
    catch(e)
    {

    }


  }

  _Dangky_pageState()
  {
    formData = {
      'class': '',

    };
  }

  bool check=false;
  BottomBarController controller;
  @override
  initState(){

    getdata(widget.data[0]["manganh"]);


    super.initState();
    controller = BottomBarController(vsync: this, dragLength: 400, snap: true);
  }
  @override
  Widget build(BuildContext context) {

    YYDialog.init(context);

    return Scaffold(
      appBar:AppBar(
        title:  Text("Đăng ký học phần",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.lightBlue,
      ),
        extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: ListTile(
          title:  Container(

            child: DropDownField(
              value: formData['class'],
            textStyle: TextStyle(fontFamily: "DancingScripre",fontSize: 20,fontWeight: FontWeight.bold),
              required: false,
              hintText: 'Chọn lớp học phần',
              labelText: hocky,

              items: classre,
              strict: true,
              setter: (dynamic newValue) {
                formData['class'] = newValue;

              },
              onValueChanged: (value) => {
                this.setState(() {
                  list_result= new List();
                 for(int i=0;i<result_arr.length;i++)
                   {
                     if(result_arr[i]["tenhocphan"].toString().toLowerCase()==value.toString().toLowerCase())
                       {
                         list_result.add(result_arr[i]);
                       }
                   }
                })
              },
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Container(
              child: ListView.builder(itemCount: list_result.length,itemBuilder: (context,index){

                return list_Item(

                  ten: list_result[index]["tenhocphan"],
                  nhom: list_result[index]["nhom"],
                  gv: list_result[index]["giangvien"],
                  thu: list_result[index]["thu"],
                  ind:index,
                  list: list_result,
                  button: "Đăng ký",
                  msv:widget.data[0]["msv"],
                  context: this.context,
                    sate: this,
                    arr:result_arr
                );


              },),
            ),
          ),

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        // Set onVerticalDrag event to drag handlers of controller for swipe effect
        onVerticalDragUpdate: controller.onDrag,
        onVerticalDragEnd: controller.onDragEnd,
        child: FloatingActionButton.extended(
          label: Text("Đã đăng ký"),
          elevation: 2,
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,

          //Set onPressed event to swap state of bottom bar
          onPressed: () =>controller.swap(),
        ),
      ),

    bottomNavigationBar: DefaultBottomBarController(
      child:BottomExpandableAppBar(
        expandedHeight: controller.dragLength,
        horizontalMargin: 14,
        controller: controller,  expandedBackColor: Colors.blueGrey,

        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),

        bottomAppBarColor: Colors.lightBlue,
        appBarHeight: 35,
        expandedBody: Padding(
          padding: const EdgeInsets.only(top:30.0),
          child: Container(
            child: ListView.builder(itemCount: dadk.length,itemBuilder: (context,index){

              return list_Item(

                ten: dadk[index]["tenhocphan"],
                nhom: dadk[index]["nhom"],
                gv: dadk[index]["giangvien"],
                thu: dadk[index]["thu"],
                ind:index,
                list: dadk,
                msv:widget.data[0]["msv"],
                context: this.context,
                button: "Hủy đăng ký",
                sate: this,
                arr:result_arr
              );


            },),
          ),
        ),

        bottomAppBarBody: Padding(

          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Text(
                  "Cao đẳng",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 15),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Expanded(
                child: Text(
                  "Vimaru",
                  style: TextStyle(color: Colors.white,fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
Map datadadk;
List resultdadk;
Future getdsdangky(String msv,State context,List arr) async {
  try {
    http.Response response = await http.get(
        Config.base_ip+"/caodangvmu/connectClient/getlistdadk.php?msv=${msv}");


    datadadk = json.decode(response.body);


    resultdadk= datadadk["data"] as List;

    context.setState(() {

      dadk= new List();
      for(int i=0;i<arr.length;i++)
        {
          for(int j=0;j<resultdadk.length;j++)
            {
              if(arr[i]["lophp_id"].toString().toLowerCase()==resultdadk[j]["lophp_id"].toString().toLowerCase())
                {
                  print(arr[i]["mahocphan"]);
                  dadk.add(arr[i]);
                  break;
                }
            }
        }
    });

  }
  catch(e)
  {

  }


}
class list_Item extends StatelessWidget {
  String ten;
  String nhom;
  String gv;
  String thu;
  int ind;
  var list;
  var button;
  String msv;
  Map datadk;
  List result;
  BuildContext context;
  State sate;
  List arr;
   list_Item({Key key, this.ten, this.nhom,this.gv,this.ind,this.button,this.list,this.thu,this.msv,this.context,this.sate,this.arr}) : super(key: key);
  Future huydangky(String msv,String lophp_id,BuildContext context) async {
    try {
      http.Response response = await http.get(
          Config.base_ip+"/caodangvmu/connectClient/huydangky.php?msv=${msv}&lophp_id=${lophp_id}");


      datadk = json.decode(response.body);


      result = datadk["data"] as List;

      if(result[0]["result"].toString().toLowerCase().trim()==("Hủy thành công!").toLowerCase().trim())
        {
          getdsdangky(msv, sate, arr);
        }
    showalert(context,result[0]["result"]);


    }
    catch(e)
    {

    }


  }

  Future  dangky(String msv,String lophp_id,BuildContext context) async {
    try {
      http.Response response = await http.get(
          Config.base_ip+"/caodangvmu/connectClient/dangkyhocphan.php?msv=${msv}&lophp_id=${lophp_id}");


      print(  Config.base_ip+"/caodangvmu/connectClient/dangkyhocphan.php?msv=${msv}&lophp_id=${lophp_id}");
      datadk = json.decode(response.body);


      result = datadk["data"] as List;

      if(result[0]["result"].toString().toLowerCase().trim()==("Đăng ký thành công!").toLowerCase().trim())
      {
        getdsdangky(msv, sate, arr);
      }
      showalert(context,result[0]["result"]);


    }
    catch(e)
    {

    }


  }
  YYDialog showalert(BuildContext context,String content) {
    return YYDialog().build(context)
      ..width = 200
      ..height = 240
      ..animatedFunc = (child, animation) {
        return ScaleTransition(
          child: child,
          scale: Tween(begin: 0.1,end: 1.0).animate(animation),
        );
      }
      ..widget(
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Container(

            alignment: Alignment.topCenter,
            child: ListTile(
              title: Icon(Icons.info_outline,color: Colors.greenAccent,),
              subtitle: Text(
                content,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
          ),
        ),
      )
      ..show();
  }

  String  getformatdate(String date)
  {

   var dateFormate = DateFormat("dd-MM-yyyy").format(DateTime.parse(date));
   return dateFormate.toString();
  }
  @override
  Widget build(BuildContext context) {


    return Card(

      color: Colors.red.withOpacity(0.8),

      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
              color: Colors.lightBlue
        ),
        child: InkWell(
          // ignore: sdk_version_set_literal
          onTap: ()=>{

            showDialog(context: context,builder: (context){
                  return new AlertDialog(
                    title:
                    Container(alignment: Alignment.center,child: Text("Chi tiết",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 30,color: Colors.lightBlue, ),)),

                    content: Container(
                      height: 350,
                      child: ListView(
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
                            child: Card (

                                child: Hero(tag:"mhp",child: Container(alignment:Alignment.center,height:50,child: Text("MHP:"+list[ind]["mahocphan"],style: TextStyle(fontSize: 20,color: Colors.lightBlue, ))))),
                          ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
                          child: Card (

                              child: Hero(tag:"name",child: Container(alignment:Alignment.center,height:50,child: Text("Tên học phần:\n"+list[ind]["tenhocphan"],style: TextStyle(fontSize: 20,color: Colors.lightBlue, ))))),
                        ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
                            child: Card( child: Hero( tag:"nhom",child: Container(alignment:Alignment.center,height:50,child: Text("Nhóm:"+list[ind]["nhom"],style: TextStyle(fontSize: 20,color: Colors.lightBlue, ))))),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
                            child: Card(child: Hero(tag:"st",child: Container(alignment:Alignment.center,height:50 ,child: Text("Số tín: ${list[ind]["sotinchi"] }",style: TextStyle(fontSize: 20,color: Colors.lightBlue, ))))),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
                            child: Card(child: Hero( tag:"tiet",child: Container(alignment:Alignment.center,height:50,child: Text("Lịch học: ${list[ind]["thu"]}",style: TextStyle(fontSize: 20,color: Colors.lightBlue, ))))),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
                            child: Card(child: Hero(tag:"gv",child: Container(alignment:Alignment.center,height:50,child: Text("Giảng Viên: \n ${list[ind]["giangvien"]}",style: TextStyle(fontSize: 20,color: Colors.lightBlue,))))),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
                            child: Card(child: Hero(tag:"tgbd",child: Container(alignment:Alignment.center,height:50,child: Text("Thời gian bắt đầu:\n    ${getformatdate(list[ind]["thoigianbatdau"].toString())}",style: TextStyle(fontSize: 20,color: Colors.lightBlue,))))),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
                            child: Card(child: Hero(tag:"tgkt",child: Container(alignment:Alignment.center,height:50,child: Text("Thời gian kết thúc :\n    ${getformatdate(list[ind]["thoigianketthuc"].toString())}",style: TextStyle(fontSize: 20,color: Colors.lightBlue,))))),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: MaterialButton(onPressed: (){

                              if(button.toString().toLowerCase().trim()==("Đăng ký").toLowerCase().trim())
                                {

                                  dangky(msv, list[ind]["lophp_id"],this.context);
                                  Navigator.of(context).pop(context);
                                }else
                                  {
                                    Navigator.of(context).pop(context);
                                    showDialog(context: context,builder: (context){
                                      return new AlertDialog(
                                        title: Text("Thông báo",style: TextStyle(fontSize: 20,color: Colors.red),),
                                        content: Text("Bạn có chắc chắn muốn hủy đăng ký lớp học này?"),
                                        actions: <Widget>[

                                          MaterialButton(
                                            onPressed: ()
                                            {

                                              dadk= new List();
                                               huydangky(msv,list[ind]["lophp_id"],this.context);
                                               Navigator.of(context).pop(context);
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
                                  }

                            },
                             color: Colors.lightBlue,

                              child: Text(button,style: TextStyle(color: Colors.white,fontSize: 15),),),
                          )
                        ],
                      ),


                    ),
                  );
                }
            )

          },
          child: Container(
            child: Column(children: <Widget>[
              Container(height:25,alignment: Alignment.center,child: Text(ten,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),

              ListTile( leading:Text("Nhóm ${nhom}",textAlign:TextAlign.center,style: TextStyle(color: Colors.white,),),trailing:  Text("Giảng Viên: ${gv}",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),) ,),

            ],),
          ),

        ),
      ),

    );
  }

}


