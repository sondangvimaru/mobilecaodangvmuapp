
import 'package:flutter/material.dart';

class Notification_detail extends StatefulWidget {
  final nofications;

  const Notification_detail({Key key, this.nofications}) : super(key: key);
  @override
  _Notification_detailState createState() => _Notification_detailState();

}

class _Notification_detailState extends State<Notification_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text(widget.nofications["tieude"]),),

      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(

            child: Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.topCenter,

                child: Text(widget.nofications["noidung"])),
        ),
      ),
    );
  }
}
