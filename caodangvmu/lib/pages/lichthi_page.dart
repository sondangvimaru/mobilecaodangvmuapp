import 'dart:convert';

import 'package:caodangvmu/config/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class lichthi_page extends StatefulWidget {
  final msv;

  const lichthi_page({Key key, this.msv}) : super(key: key);
  @override
  _lichthi_pageState createState() => _lichthi_pageState();
}

class _lichthi_pageState extends State<lichthi_page> {

  Map data;
  List result_arr= new List();

  Future getlichthi(String msv) async {
    try {
      http.Response response = await http.get(
          Config.base_ip+"/caodangvmu/connectClient/lichthi.php?msv=${msv}");


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
    getlichthi(widget.msv);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch Thi",style: TextStyle(color: Colors.white,fontSize: 20),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(itemCount: result_arr.length,itemBuilder: (context,index){

        return list_Item(

          tenhp: result_arr[index]["tenhocphan"],
          thoigianthi: result_arr[index]["thoigian"],
          diadiem: result_arr[index]["diadiem"],
          sbd: result_arr[index]["sdb"],
          hinhthuc: result_arr[index]["hinhthuc"],
        );


      },),




      ),

    );
  }
}

class list_Item extends StatelessWidget {
  final tenhp;
  final thoigianthi;
  final diadiem;
  final sbd;
  final hinhthuc;

  const list_Item({Key key, this.tenhp, this.thoigianthi, this.diadiem, this.sbd, this.hinhthuc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
                Card(
                  color: Colors.lightBlue,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),

                  ),
              child: Ink(


                  child: Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.topCenter,
                          child: Text("Học phần:",style: TextStyle(fontSize: 20,color: Colors.white))),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Text("${tenhp}",style: TextStyle(fontSize: 20,color: Colors.white))),


                      Align(
                          alignment: Alignment.topCenter,
                          child: Text("Thời Gian:",style: TextStyle(fontSize: 20,color: Colors.white))),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Text("${thoigianthi}",style: TextStyle(fontSize: 20,color: Colors.white))),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Text("Địa Điểm:",style: TextStyle(fontSize: 20,color: Colors.white))),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Text("${diadiem}",style: TextStyle(fontSize: 20,color: Colors.white))),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Text("Số báo danh:",style: TextStyle(fontSize: 20,color: Colors.white))),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Text("${sbd}",style: TextStyle(fontSize: 20,color: Colors.white))),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Text("Hình Thức:",style: TextStyle(fontSize: 20,color: Colors.white))),

                      Align(
                          alignment: Alignment.topCenter,
                          child: Text("${hinhthuc}",style: TextStyle(fontSize: 20,color: Colors.white))),


                    ],
                  )),
            );
  }
}
