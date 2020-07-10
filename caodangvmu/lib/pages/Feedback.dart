import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:caodangvmu/config/config.dart';
import 'package:caodangvmu/widget/ReceivedfeedbackWidget.dart';
import 'package:caodangvmu/widget/Sendfeedbackwidget.dart';
import 'package:chewie/chewie.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
class LienHePage extends StatefulWidget {
  final msv;

  const LienHePage({Key key, this.msv}) : super(key: key);
  @override
  _LienHePageState createState() => _LienHePageState();
}

class _LienHePageState extends State<LienHePage> {
  TextEditingController _controller;
  ScrollController _scrollController;
  Future<void>futureController;
  Map data;
  List feed_back_list= new List();
  var childList = <Widget>[];
  Future openfile()async{

    List<File> files = await FilePicker.getMultiFile();

    files.forEach((element) {
     var data= element.readAsBytesSync();
      String base64 = base64Encode(data);
     String ex = extension(element.path);
     print(ex);
      sendfiledata(widget.msv, base64,ex,gettype(ex));
    });

    print(files.toString());
  }
  String gettype(String ex)
  {
    if(ex.trim().toLowerCase()==".jpg".toLowerCase() ||
        ex.trim().toLowerCase()==".jpeg".toLowerCase() ||
        ex.trim().toLowerCase()==".png".toLowerCase() ||
        ex.trim().toLowerCase()==".gif".toLowerCase() ||
        ex.trim().toLowerCase()==".tiff".toLowerCase()


    ) {
      return "image";
    }
    else if(ex.trim().toLowerCase()==".mp4".toLowerCase() ||
        ex.trim().toLowerCase()==".avi".toLowerCase() ||
        ex.trim().toLowerCase()==".mov".toLowerCase() ||
        ex.trim().toLowerCase()==".flv".toLowerCase() ||
        ex.trim().toLowerCase()==".wmv".toLowerCase()
          )
    {
      return "video";
    }

    return "anyfile";


  }
  Future sendtextdata(String msv ,String content,BuildContext context) async {

    try
        {
          http.Response response = await  http.post(Config.base_ip+"/caodangvmu/connectClient/nhanphanhoi.php",
              body: <String,String>{
                "content": "${content}",
                "msv":"${msv}",
                "type":"text"
              }) ;
        setState(() {
          _controller.clear();
        });

        }catch(e)
    {

    }
  }
  _launchURL(String url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future getmessenger(String msv)async{

    try
    {
      http.Response response = await  http.post(Config.base_ip+"/caodangvmu/connectClient/getallfeedback.php",
          body: <String,String>{
            "msv":"${msv}",
          }) ;

      data= json.decode(response.body);



      setState(() {
        feed_back_list=data["data"] as List;
    feed_back_list.forEach((element) {
      if(element["type"].toString().trim().toLowerCase()=="image")
        {

          if(element["from_user"].toString().toLowerCase().trim()=="0")
            {
              childList.add(
                  Align(
                    alignment: Alignment(1, 0),
                    child: SendedMessageWidget(
                      content:Image.network(Config.base_ip+"/caodangvmu/images/"+element["content"],width: 250,height: 250),
                      time: element["time"],
                    ),
                  )
              );
            }else
              {
                childList.add(
                    Align(
                      alignment: Alignment(-1, 0),
                      child: ReceivedMessageWidget(
                        content:Image.network(Config.base_ip+"/caodangvmu/images/"+element["content"]),
                        time: element["time"],
                      ),
                    )
                );

              }
        }
      else if(element["type"].toString().trim().toLowerCase()=="video")
        {


      video_controller= VideoPlayerController.network(Config.base_ip+"/caodangvmu/video/"+element["content"]);

          Future<void>futureController=video_controller.initialize();
          video_controller.setVolume(25.0);

          video_controller.setLooping(false);
       //   video_controller.play();
        if(element["from_user"].toString().toLowerCase().trim()=="0")
            {
              childList.add(
                  Align(
                    alignment: Alignment(1, 0),
                    child: SendedMessageWidget(
                      content:Stack(
                        children: <Widget>[
                          FutureBuilder(
                            future: futureController,
                            builder: (context,snapshot){
                              if(snapshot.connectionState==ConnectionState.done)
                                {
                                    return Container(
                                        width: 250,
                                        height: 250,
                                        child: VideoPlayer(video_controller));
                                }else
                                  {
                                            return Center(child: CircularProgressIndicator(),);
                                  }
                            },
                          ),
                          Center(
                              child:
                              ButtonTheme(
                                  height: 100.0,
                                  minWidth: 200.0,
                                  child: RaisedButton(
                                    padding: EdgeInsets.all(60.0),
                                    color: Colors.transparent,
                                    textColor: Colors.white,
                                    onPressed: () {

                                      setState(() {

                                        if (video_controller.value.isPlaying) {
                                          video_controller.pause();
                                        } else {

                                          video_controller.play();
                                        }
                                      });
                                    },
                                    child: Icon(
                                      video_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                      size: 120.0,
                                    ),
                                  ))
                          )
                        ],
                      ),
                      time: element["time"],
                    ),
                  )
              );
            }
          else
            {
              childList.add(
                  Align(
                    alignment: Alignment(-1, 0),
                    child: ReceivedMessageWidget(
                      content:FutureBuilder(
                        future: futureController,
                        builder: (context,snapshot){
                          if(snapshot.connectionState==ConnectionState.done)
                          {
                        return AspectRatio(
                              aspectRatio: video_controller.value.aspectRatio,

                              child: VideoPlayer(video_controller),
                            );
                          }else
                          {
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                      ),
                      time: element["time"],
                    ),
                  )
              );
            }
        }
      else  if(element["type"].toString().trim().toLowerCase()=="text")
        {
          if(element["from_user"].toString().toLowerCase().trim()=="0")
          {
            childList.add(
                  Align(
                    alignment: Alignment(1,0),
                    child: SendedMessageWidget(

                      content: Text(element["content"]),
                      time: element["time"],
                    ),

                  )
            );

          }else
            {
              childList.add(
                  Align(
                    alignment: Alignment(1,0),
                    child: ReceivedMessageWidget(

                      content: Text(element["content"]),
                      time: element["time"],
                    ),

                  )
              );
            }

        }
      else{

        if(element["from_user"].toString().toLowerCase().trim()=="0")
          {
            childList.add(
                Align(
                  alignment: Alignment(1,0),
                  child: SendedMessageWidget(

                    content: InkWell(

                        onTap: (){
                          _launchURL(Config.base_ip+"/caodangvmu/anyfile/"+element["content"]);
                        },
                        child: Text(element["content"])),
                    time: element["time"],
                  ),

                )
            );

          }else
            {
              childList.add(
                  Align(
                    alignment: Alignment(1,0),
                    child: ReceivedMessageWidget(

                      content: InkWell(
                          onTap: (){
                            _launchURL(Config.base_ip+"/caodangvmu/anyfile/"+element["content"]);
                          },
                          child: Text(element["content"])),
                      time: element["time"],
                    ),

                  )
              );
            }

      }
    });

        Timer(
          Duration(seconds: 1),
              () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
        );

      });

    }catch(e)
    {
    print(e.toString());
    }

  }
  Future sendfiledata(String msv ,String content,String ex,String type) async {

    try
    {
      http.Response response = await  http.post(Config.base_ip+"/caodangvmu/connectClient/nhanfilephanhoi.php",
          body: <String,String>{
            "content": "${content}",
            "msv":"${msv}",
            "type":"${type}",
            "ex":"${ex}"
          }) ;
      setState(() {
        _controller.clear();
      });

    }catch(e)
    {

    }
  }
  VideoPlayerController video_controller;
  @override
  void initState() {
   _controller= TextEditingController();
  _scrollController = ScrollController();


    getmessenger(widget.msv);

    super.initState();
  }

  @override
  void dispose() {
     _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Liên Hệ Phản Hồi"),),

      body:  SafeArea(
        child: Container(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: <Widget>[

                  Flexible(
                    fit: FlexFit.tight,
                    // height: 500,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: new AssetImage(
                                "images/bgr.jpg"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.linearToSrgbGamma()),
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                          // reverse: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                           children: childList,
                          )),
                    ),
                  ),
                  Divider(height: 0, color: Colors.black26),
                  // SizedBox(
                  //   height: 50,
                  Container(
                    color: Colors.white,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        maxLines: 20,
                        controller: _controller,
                        decoration: InputDecoration(
                         prefixIcon: IconButton(
                            icon: Icon(Icons.attach_file),
                        onPressed: () {
                          openfile();
                        },
                      ),
                          // contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              if(!_controller.text.trim().isEmpty)
                                {

                                  sendtextdata(widget.msv, _controller.text, context);

                                }

                            },
                          ),
                          border: InputBorder.none,
                          hintText: "nhập tin nhắn",
                        ),
                      ),
                    ),
                  ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}

