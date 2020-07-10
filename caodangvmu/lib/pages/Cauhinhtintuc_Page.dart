import 'dart:convert';

import 'package:caodangvmu/config/config.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class Cauhinh_Pages extends StatefulWidget {
  @override
  _Cauhinh_PagesState createState() => _Cauhinh_PagesState();
}

class _Cauhinh_PagesState extends State<Cauhinh_Pages> {
  List _danhsachdanhmuc= new List();
  List result_select = new List();


  Map list_tmp;
  List<Widget> selectedOptions= new List();
  List list_checked = new List();
  final formKey = new GlobalKey<FormState>();
  TextEditingController _controller ;

  Future getdanhmuc() async {
    try {
      http.Response response = await http.get(
          Config.base_ip+"/caodangvmu/connectClient/getdanhmuc.php");

    list_tmp=json.decode(response.body);
    setState(() {
      _danhsachdanhmuc = list_tmp["data"] as List;
      isset();
    });



    }
    catch(e)
    {

    }


  }

  Future<void> isset() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey("list_dm"))
    {

      setState(() {
        result_select=prefs.getStringList("list_dm");
    result_select.forEach((item) {
          var existingItem = _danhsachdanhmuc.singleWhere((itm) => itm["danhmuc_id"] == item, orElse: () => null);
          selectedOptions.add(Chip(
            label: Text(existingItem["tendanhmuc"], overflow: TextOverflow.ellipsis),
          ));
        });

    });

      result_select.forEach((element) {

        list_checked.add(int.parse(element.toString()));
      });


          }

    if(prefs.containsKey("limit_news"))
    {

     setState(() {
       _controller.text=prefs.getString("limit_news");
     });


    }



  }
  adddatatoSF(String key,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    Toast.show("Lưu thành công", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
  }
  adddatalisttoSF(String key,List<String> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, data);
    Toast.show("Lưu thành công", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
  }

  @override
  void initState() {
    _controller=  TextEditingController();

   getdanhmuc();

   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Cấu hình tin tức",style: TextStyle(color: Colors.white)),),
      body: ListView(

        children: <Widget>[

      Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextField(


          controller: _controller,
           keyboardType: TextInputType.number
        ,
        decoration: new InputDecoration(
        border: new OutlineInputBorder(
        borderSide: new BorderSide(color: Colors.blue.withOpacity(0.6))),
        hintText: 'Số lượng tin tức hiển thị',
     helperText: 'Số lượng tối đa mà tin tức có thể hiển thị trên trang chủ.',
     labelText: 'Số Lượng',
     prefixIcon: const Icon(
    Icons.format_list_numbered_rtl,
    color: Colors.blueAccent,

    ),
   ),

    ),
      ),


          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: FlatButton(
              onPressed: (){
                adddatatoSF("limit_news", _controller.text.toString());
              },
              child: Text('Save', style: TextStyle(
                  color: Colors.blue
              )
              ),
              textColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(side: BorderSide(
                  color: Colors.blue,
                  width: 1,
                  style: BorderStyle.solid
              ), borderRadius: BorderRadius.circular(40)),
            ),
          ),
          Text("Danh mục hiển thị",style: TextStyle( fontFamily: 'DancingScrip',color: Colors.blueAccent,fontSize: 30,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: MultiSelectFormField(

              autovalidate: false,
              titleText: 'Danh sách danh mục',


              validator: (value) {
                if (value == null || value.length == 0) {

                  return 'Chọn danh mục tin tức bạn muốn xem';
                }
                return null;
              },
              dataSource:  _danhsachdanhmuc,
              textField: 'tendanhmuc',
              valueField: 'danhmuc_id',
              okButtonLabel: 'Chọn',
              cancelButtonLabel: 'Hủy Bỏ',
              init_selected: result_select,
              selected_init: selectedOptions,
              // required: true,
              hintText: 'Chọn danh mục tin tức bạn muốn xem',

              onSaved: (value) {
                if (value == null) return;
                setState(() {
                  result_select = value;
                });

              },

            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
            child: FlatButton(
              onPressed: (){
               List<String> list_dm= new List();
                for(var item in result_select)
                  {
                    list_dm.add(item.toString());
                  }

                adddatalisttoSF("list_dm", list_dm);

              },
              child: Text('Save', style: TextStyle(
                  color: Colors.blue
              )
              ),
              textColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(side: BorderSide(
                  color: Colors.blue,
                  width: 1,
                  style: BorderStyle.solid
              ), borderRadius: BorderRadius.circular(40)),
            ),
          ),
        ],
      ),
    );
  }
}
