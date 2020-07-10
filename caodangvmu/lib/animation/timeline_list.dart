import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class Timeline_List extends StatelessWidget {
  List<String> images;

   Timeline_List({Key key, this.images}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return timelineModel(TimelinePosition.Right);
  }
  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: 5,
      physics: position == TimelinePosition.Left
          ? ClampingScrollPhysics()
          : BouncingScrollPhysics(),
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {

    return TimelineModel(
        Card(
          margin: EdgeInsets.symmetric(vertical: 16.0),
//          shape:
//          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child:  Image(image: AssetImage('images/slide1.jpg')),
            )
          ),
        ),
        position:
        i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == 5,
        iconBackground: Colors.blueAccent,
        icon: Icon(Icons.ac_unit));
  }
}
