

import 'dart:convert';

import 'package:caodangvmu/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class tkb_page extends StatefulWidget {
  final msv;

  const tkb_page({Key key, this.msv}) : super(key: key);

  @override
  _tkb_pageState createState() => _tkb_pageState();
}


class _tkb_pageState extends State<tkb_page> {
  Map datatkb;
  List result_arr= new List();
  Future getdata(String msv) async {
    try {
      http.Response response = await http.get(
          Config.base_ip+"/caodangvmu/connectClient/tkb.php?msv=${msv}");


      datatkb = json.decode(response.body);





      setState(() {
        result_arr = datatkb["data"] as List;
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
      appBar: AppBar(
        title: Text("Thời khóa biểu"),
        backgroundColor: Colors.lightBlue,


      ),
      body: GridView.builder(itemCount:result_arr.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

    itemBuilder: (BuildContext context,int index)
    {
    return item_grid_view(
      ten: result_arr[index]["tenhocphan"],
      lich: result_arr[index]["thu"],
      diadiem: result_arr[index]["diadiem"]


    );



    }),


    );
  }
}
class item_grid_view extends StatelessWidget {
  String ten;
  String lich;
  String diadiem;
   item_grid_view({Key key, this.ten,this.lich,this.diadiem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag:ten,
        child: Material(
          color: Colors.lightBlue,
          child: Container(

            child: Column(
              children: <Widget>[
                Container(alignment:Alignment.center,child: Text(ten,style: TextStyle(color: Colors.white,fontSize: 20),)),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text("Thời gian:",style: TextStyle(color: Colors.white,fontSize: 15),),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(lich,style: TextStyle(color: Colors.white,fontSize: 15),),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text("Địa điểm:",style: TextStyle(color: Colors.white,fontSize: 15),),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(diadiem,style: TextStyle(color: Colors.white,fontSize: 15),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
