
import 'dart:convert';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:caodangvmu/config/config.dart';
import 'package:caodangvmu/main.dart';
import 'package:caodangvmu/pages/Cauhinhtintuc_Page.dart';
import 'package:caodangvmu/pages/Editinfo_Page.dart';
import 'package:caodangvmu/pages/Feedback.dart';
import 'package:caodangvmu/pages/resetpassword_page.dart';
 
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class User_page extends StatefulWidget {
  final msv;

  const User_page({Key key, this.msv}) : super(key: key);
  @override
  _User_pageState createState() => _User_pageState();
}
String name= " ";
double widthd=0;
double heightd=0;
double size_v=2;
Color current_color_v=Colors.purpleAccent;
Color current_color_vt=Colors.purpleAccent;
double pd=0;
Color current_color=Colors.blueAccent;
Color current_wave_color=Colors.white54;
Color current_text_color=Colors.blueAccent;
var img= AssetImage("images/${name}");
String ten=" ",anh_dai_dien=" ";
Map data;
List result_arr;
adddatatoSF(String key,String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}
class _User_pageState extends State<User_page> {



  getdatainSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String stringValue = prefs.getString(key);
    return stringValue;
  }
  Future<void> isset() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey("name"))
    {
      name=prefs.getString("name");

     setState(() {

       img= AssetImage("images/${name}");

     });

    }
    if(prefs.containsKey("widthd"))
    {
      setState(() {
        widthd=double.parse(prefs.getString("widthd"));
      });
    }
    if(prefs.containsKey("heightd"))
    {
     setState(() {
       heightd=double.parse(prefs.getString("heightd"));
     });

    }
    if(prefs.containsKey("size_v"))
    {
     setState(() {
       size_v=double.parse(prefs.getString("size_v"));
     });
    }
    if(prefs.containsKey("pd"))
    {
      setState(() {
        pd=double.parse(prefs.getString("pd"));
      });
    }
    if(prefs.containsKey("current_color"))
    {
      setState(() {
        int  v=int.parse(prefs.getString("current_color"));
        current_color= new Color(v);

      });
    }
    if(prefs.containsKey("current_color_v"))
    {
      setState(() {
        int  v=int.parse(prefs.getString("current_color_v"));
        current_color_v= new Color(v);

      });
    }

    if(prefs.containsKey("current_color_vt"))
    {
      setState(() {
        int  v=int.parse(prefs.getString("current_color_vt"));
        current_color_vt= new Color(v);

      });
    }
    if(prefs.containsKey("current_text_color"))
    {
      setState(() {
        int  v=int.parse(prefs.getString("current_text_color"));
        current_text_color= new Color(v);

      });
    }

    if(prefs.containsKey("current_wave_color"))
    {
      setState(() {
        int  v=int.parse(prefs.getString("current_wave_color"));
        current_wave_color= new Color(v);

      });
    }
  }
  void changeColor(Color color) {
    setState(() {
      current_color = color;
      adddatatoSF("current_color", current_color.value.toString());
    });
  }
  void changeColor_v(Color color) {
    setState(() {
      current_color_v = color;
      adddatatoSF("current_color_v", current_color_v.value.toString());
    });
  }
  void changeColor_wave(Color color) {
    setState(() {
      current_wave_color=color;
      adddatatoSF("current_wave_color", current_wave_color.value.toString());

    });
  }
  void changeColor_text(Color color) { setState(() {
    current_text_color = color;
    adddatatoSF("current_text_color", current_text_color.value.toString());
  });
}

  Future getdata(String msv) async {
    try {
      http.Response response = await http.get(
          Config.base_ip+"/caodangvmu/connectClient/getsv.php?msv=${msv}");


      data = json.decode(response.body);


      result_arr = data["data"] as List;
      setState(() {

        ten=result_arr[0]["ten"];

        anh_dai_dien=result_arr[0]["anh_dai_dien"];

      });

    }
    catch(e)
    {

    }


  }
  @override
  void initState() {
    getdata(widget.msv);
      isset();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    hexcolor(String color)
    {
      String colornew="0xff"+color;
      colornew=colornew.replaceAll("#", '');
      int colorint=int.parse(colornew);
      return colorint;
    }
  
  
    var frame_list=[
      {
        "imagename":"none.png",
        "width" : "0",
        "height":"0",
        "pd":"0"
      },
      {
        "imagename":"frame.png",
        "width" : "175",
        "height":"190",
        "pd":"22"
      },
      {
        "imagename": "frame2.gif",
        "width": "250",
        "height": "250",
           "pd":"0"
      },
      {
        "imagename":"frame3.gif",
        "width" :"250",
        "height":"250",
        "pd":"0"
      },
      {
        "imagename":"frame4.gif",
        "width" : "196",
        "height":"196",
        "pd":"26"
      },
      {
        "imagename":"frame5.gif",
        "width" : "250",
        "height":"250",
        "pd":"0"
      },
      {
        "imagename":"frame6.gif",
        "width" : "250",
        "height":"250",
        "pd":"0"
      },
      {
        "imagename":"frame.gif",
        "width" : "180",
        "height":"180",
        "pd":"30"
      },

    ];
    var size_controller=TextEditingController();
    return Scaffold(

      backgroundColor: current_color,
      body: Container(

        child: ListView(

          children: <Widget>[
            Container(

              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 5),
              child: Stack(
                children: <Widget>[



                   Container(

                     padding: EdgeInsets.only(top: 46.0),
                    alignment: Alignment.topCenter,
                    child: CircularProfileAvatar(
                      null,
                      child: InkWell(

                          onTap: (){

                          },

                          child: Image.network(Config.base_ip+"/caodangvmu/images/${anh_dai_dien}")),
                      borderColor: current_color_vt,
                      borderWidth: size_v,

                      radius: 78,

                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: pd),
                    child: Container(
                      alignment: Alignment.topCenter,

                      child: Image(

                          fit: BoxFit.cover,

                          image: img,

                          width: widthd,
                        height: heightd,
                      ),
                    ),
                  ),
                ],

              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 6.0),

            ),


       Stack(
         children: <Widget>[

           Container(


             alignment: Alignment.topCenter,
             child: SizedBox(

               child: TextLiquidFill(

                 text: 'Linh Hương',
                 waveColor: current_wave_color,
                 boxBackgroundColor: Colors.transparent,
                 textStyle: TextStyle(
                     fontSize: 40.0,
                     fontWeight: FontWeight.bold,
                     fontFamily: 'DancingScrip'
                 ),

                 loadDuration: Duration(milliseconds: 300),
                 boxHeight: 50,
               ),
               height: 60,
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(top: 10.0),
             child: Container(

                 alignment: Alignment.center,

                 child: Text(ten,textAlign: TextAlign.center,style:  TextStyle(
                       fontSize: 30.0,

                       fontWeight: FontWeight.bold,
                       color: current_text_color,
                       fontFamily: 'DancingScrip'
                   ),
                 )),
           )
         ],
       ),


            Padding(

              padding: EdgeInsets.only(top: 12.0),

            ),





                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0.0 , 10, 0.0),
                    child: Container(

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 15)],

//                          gradient: LinearGradient(colors: [Color(hexcolor("#FFECD2")),Color(hexcolor("##FCB69F"))])

                      ),




               ),
                  ),


            Padding(
              padding: EdgeInsets.fromLTRB(10, 10.0 , 10, 0.0),
              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 15)],
                  //  gradient: LinearGradient(colors: [Color(hexcolor("#FFECD2")),Color(hexcolor("##FCB69F"))])
                ),

                child: ListTile(

                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ResetPage(msv:widget.msv)));

                  },
                  leading: Text("Đổi mật khẩu",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                      fontFamily: "DancingScrip"
                  ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Icon(Icons.vpn_key,size: 30,color: Colors.lightBlue,),
                  ),
                ),


              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10.0 , 10, 0.0),
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 15)],
                  //  gradient: LinearGradient(colors: [Color(hexcolor("#FFECD2")),Color(hexcolor("##FCB69F"))])
                ),

                child: ListTile(

                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cauhinh_Pages()));

                  },
                  leading: Text("Cấu Hình Tin Tức",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        fontFamily: "DancingScrip"
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Icon(Icons.insert_drive_file,size: 30,color: Colors.lightBlue,),
                  ),
                ),


              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10.0 , 10, 0.0),
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 15)],
                  //  gradient: LinearGradient(colors: [Color(hexcolor("#FFECD2")),Color(hexcolor("##FCB69F"))])
                ),

                child: ListTile(

                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LienHePage(msv:widget.msv)));

                  },
                  leading: Text("Liên Hệ&Phản hồi",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        fontFamily: "DancingScrip"
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Icon(Icons.insert_drive_file,size: 30,color: Colors.lightBlue,),
                  ),
                ),


              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10.0 , 10, 0.0),
              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 15)],
                  //  gradient: LinearGradient(colors: [Color(hexcolor("#FFDDE1")),Color(hexcolor("#EE9CA7"))])
                ),

                child: ListTile(

                  onTap: (){

                    showDialog(context: context,builder: (context){
                      return new AlertDialog(
                        title: Text("chọn khung",style: TextStyle(fontSize: 20,color: Colors.red),),
                        content: GridView.builder(itemCount: frame_list.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemBuilder: (BuildContext context,int index){
                          return
                              item_frame(
                              image_name: frame_list[index]["imagename"],
                                width:frame_list[index]["width"] ,
                                height: frame_list[index]["height"],
                                widget: this,
                                cont:context,
                                pdl: double.parse(frame_list[index]["pd"]),
                              );

                            }) ,
                        actions: <Widget>[


                          MaterialButton(
                            onPressed: ()
                            {
                              Navigator.of(context).pop(context);

                            },
                            child: Text("Hủy"),
                          )
                        ],

                      );
                    });
                  },
                  leading: Text("Đổi khung",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        fontFamily: "DancingScrip"
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Icon(Icons.filter_frames,size: 30,color: Colors.lightBlue,),
                  ),
                ),


              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10.0 , 10, 0.0),
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 15)],

//                          gradient: LinearGradient(colors: [Color(hexcolor("#FFECD2")),Color(hexcolor("##FCB69F"))])

                ),

                child: ListTile(

                  onTap: (){

                    showDialog(context: context,builder: (context){
                      return new AlertDialog(

                        title: Text("Đổi viền",style: TextStyle(fontSize: 20,color: Colors.red),),
                        content: Container(
                          width: 300,
                          height: 150,
                          child: ListView(
                            children: <Widget>[
                              MaterialButton(onPressed: ()=>{
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      titlePadding: const EdgeInsets.all(0.0),
                                      contentPadding: const EdgeInsets.all(0.0),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: current_color_v,
                                          onColorChanged: changeColor_v,
                                          colorPickerWidth: 300.0,
                                          pickerAreaHeightPercent: 0.7,
                                          enableAlpha: true,
                                          displayThumbColor: true,
                                          showLabel: true,
                                          paletteType: PaletteType.hsv,
                                          pickerAreaBorderRadius: const BorderRadius.only(
                                            topLeft: const Radius.circular(2.0),
                                            topRight: const Radius.circular(2.0),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              },
                                color:current_color_v,
                                child: Text("Màu"),
                                textColor: Colors.blueAccent,
                              ),
                              TextFormField(
                                controller: size_controller,
                                decoration: InputDecoration(

                                  hintText: "Size",
                                  icon: Icon(Icons.photo_size_select_large,color: Colors.blueAccent,),
                                  labelText: "Size",
                                  labelStyle: TextStyle(
                                      color: Colors.blueAccent,fontWeight: FontWeight.bold,
                                      fontSize: 16.0
                                  ),
                                  focusColor: Colors.red,




                                ),
                                keyboardType: TextInputType.number,
                              ) ,
                            ],



                          ),
                        ),
                        actions: <Widget>[

                          MaterialButton(
                            onPressed: ()
                            {
                              Navigator.of(context).pop(context);

                                  setState(() {

                                    current_color_vt=current_color_v;
                                  size_v=double.parse(size_controller.text.trim());
                                  adddatatoSF("current_color_vt", current_color_vt.value.toString());
                                  adddatatoSF("size_v",size_v.toString());
                                  });
                            },
                            child: Text("Đổi"),
                          ),

                          MaterialButton(
                            onPressed: ()
                            {

                              Navigator.of(context).pop(context);

                            },
                            child: Text("Hủy"),
                          )
                        ],

                      );
                    });

                  },
                  leading: Text("Đổi Viền", style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      fontFamily: "DancingScrip"
                  ),),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Icon(Icons.fiber_manual_record,size: 30,color: Colors.lightBlue,),
                  ),
                ),


              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10.0 , 10, 0.0),
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 15)],

//                          gradient: LinearGradient(colors: [Color(hexcolor("#FFECD2")),Color(hexcolor("##FCB69F"))])

                ),

                child: ListTile(

                  onTap: (){
    showDialog(context: context,builder: (context)
    {
      return new AlertDialog(


        backgroundColor: Colors.transparent,
        content: Container(
          alignment: Alignment.center,
          width: 300,
          height: 300,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),

                  child: MaterialButton(
                    color: Colors.white,

                    onPressed: ()=>{
                      Navigator.of(context).pop(context),
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0.0),
                            contentPadding: const EdgeInsets.all(0.0),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: current_wave_color,
                                onColorChanged: changeColor_wave,
                                colorPickerWidth: 300.0,
                                pickerAreaHeightPercent: 0.7,
                                enableAlpha: true,
                                displayThumbColor: true,
                                showLabel: true,
                                paletteType: PaletteType.hsv,
                                pickerAreaBorderRadius: const BorderRadius.only(
                                  topLeft: const Radius.circular(2.0),
                                  topRight: const Radius.circular(2.0),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    },
                    child: Text("Đổi màu sóng"),
                    textColor: Colors.blueAccent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),

                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),

                  child: MaterialButton(
                    color: Colors.white,
                    onPressed: ()=>{
                      Navigator.of(context).pop(context),
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0.0),
                            contentPadding: const EdgeInsets.all(0.0),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: current_text_color,
                                onColorChanged: changeColor_text,
                                colorPickerWidth: 300.0,
                                pickerAreaHeightPercent: 0.7,
                                enableAlpha: true,
                                displayThumbColor: true,
                                showLabel: true,
                                paletteType: PaletteType.hsv,
                                pickerAreaBorderRadius: const BorderRadius.only(
                                  topLeft: const Radius.circular(2.0),
                                  topRight: const Radius.circular(2.0),
                                ),
                              ),
                            ),
                          );
                        },
                      )

                    },
                    child: Text("Đổi màu chữ"),textColor: Colors.blueAccent,),
                ),
              ),
            ]
            ,


          ),
        ),
      );

     });
                  },
                  leading: Text("Đổi Sóng", style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      fontFamily: "DancingScrip"
                  ),),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Icon(Icons.arrow_forward_ios,size: 30,color: Colors.lightBlue,),
                  ),
                ),


              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10.0 , 10, 0.0),
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 15)],

//                          gradient: LinearGradient(colors: [Color(hexcolor("#FFECD2")),Color(hexcolor("##FCB69F"))])

                ),

                child: ListTile(

                  onTap: (){


                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          titlePadding: const EdgeInsets.all(0.0),
                          contentPadding: const EdgeInsets.all(0.0),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: current_color,
                              onColorChanged: changeColor,
                              colorPickerWidth: 300.0,
                              pickerAreaHeightPercent: 0.7,
                              enableAlpha: true,
                              displayThumbColor: true,
                              showLabel: true,
                              paletteType: PaletteType.hsv,
                              pickerAreaBorderRadius: const BorderRadius.only(
                                topLeft: const Radius.circular(2.0),
                                topRight: const Radius.circular(2.0),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  leading: Text("Đổi màu nền", style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      fontFamily: "DancingScrip"
                  ),),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Icon(Icons.color_lens,size: 30,color: Colors.lightBlue,),
                  ),
                ),


              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10.0 , 10, 0.0),
              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 15)],
                   // gradient: LinearGradient(colors: [Color(hexcolor("#FFECD2")),Color(hexcolor("##FCB69F"))])
                ),




              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10.0 , 10, 0.0),
              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.white70, blurRadius: 15)],
                  //  gradient: LinearGradient(colors: [Color(hexcolor("#FFDDE1")),Color(hexcolor("#EE9CA7"))])
                ),

                child: ListTile(

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
                  leading: Text("Đăng Xuất",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        fontFamily: "DancingScrip"
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Icon(IconData(0xe800, fontFamily: "_kFontFam"),size: 30,color: Colors.lightBlue,),
                  ),
                ),


              ),
            ),
            Padding(

              padding: EdgeInsets.only(top: 40),
            )
          ],
        ),
      ),
    );
  }
}
class item_frame extends StatelessWidget {
final image_name;
 String width;
 String height;
 double pdl;
final _User_pageState widget;
final cont;
  item_frame({Key key, this.image_name, this.width, this.height, this.widget,this.cont,this.pdl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Hero(
    tag: image_name,
        child: Material(child: InkWell(

          onTap: ()=>{

          widget.setState(() {
            name=image_name;
            if(name.trim().toLowerCase().endsWith("none"))
              {
                img=null;
              }
            else {

              Navigator.of(cont).pop(cont);
              widthd = num.tryParse(width)?.toDouble();
              heightd = num.tryParse(height)?.toDouble();
              pd = pdl;
              adddatatoSF("widthd", widthd.toString());
              adddatatoSF("heightd", heightd.toString());
              adddatatoSF("pd", pdl.toString());
              adddatatoSF("name", image_name);
              img=AssetImage("images/${image_name}");
            }
          })
          },

child: GridTile(

    child: Image.asset("images/${image_name}") ,
),
        ),

        ),
      ),
    );
  }
}
