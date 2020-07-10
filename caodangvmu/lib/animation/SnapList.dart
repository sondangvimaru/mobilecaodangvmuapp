import 'package:caodangvmu/config/config.dart';
import 'package:caodangvmu/pages/news_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snaplist/snaplist.dart';

class HorizontalTab extends StatelessWidget {
  final List baidang;
  final VoidCallback loadMore;

  const HorizontalTab({Key key, this.baidang, this.loadMore}) : super(key: key);
  String  getformatdate(String date)
  {

    var dateFormate = DateFormat("dd-MM-yyyy h:mm:ss").format(DateTime.parse(date));
    return dateFormate.toString();
  }
  @override
  Widget build(BuildContext context) {
    final Size cardSize = Size(280.0, 350.0);
    return SnapList(
      padding: EdgeInsets.only(
          left: (MediaQuery.of(context).size.width - cardSize.width) / 2),
      sizeProvider: (index, data) => cardSize,
      separatorProvider: (index, data) => Size(10.0, 10.0),

      builder: (context, index, data) {
        return InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> News_view( url:Config.base_ip+"/fontendcaodang/baidangdetail.php?baidang_id=${baidang[index]["baidang_id"]}" ,tieude:  baidang[index]["tieude"],)));

          },
          child: Container(
            child: Card(
              child: Stack(
                children: <Widget>[


                  new Container(

                     decoration: new BoxDecoration(

                       borderRadius: BorderRadius.circular(20.0),
                       image: new DecorationImage(image: new NetworkImage(Config.base_ip+"/caodangvmu/images/${baidang[index]["anh_dai_dien"]}"), fit: BoxFit.cover,),


                     ),


                   ),
                    Container(
                      height:60,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.6),
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0) ,topRight: Radius.circular(20.0) )
                      ),
                    ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 1.5),
                      child: ListTile(title:Text("Đăng lúc :",style: TextStyle( fontFamily: 'DancingScrip',color: Colors.white,fontSize: 20,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                      ,subtitle:Text(getformatdate(baidang[index]["thoigiandang"]),style: TextStyle( fontFamily: 'DancingScrip',color: Colors.white,fontSize: 20,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                                                      ),
                    ),
                  ),

                onBottom(  Container(
                    height: 80,
                    alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.5)
                      ,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0))

                  ),
                  ))
                  ,onBottom(

                     Container( height: 140, alignment:Alignment.bottomCenter,child:Text( baidang[index]["tieude"],style: TextStyle(fontSize: 15,
                        color: Colors.white,fontWeight:FontWeight.bold),textAlign: TextAlign.center)),
                  )



                ],
              ),
            ),
          ),
        );
      },
      count: baidang.length,
    );
  }
}
onBottom(Widget child) => Positioned.fill(
  child: Align(
    alignment: Alignment.bottomCenter,
    child: child,
  ),
);