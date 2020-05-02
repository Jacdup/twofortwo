import 'package:flutter/material.dart';
import 'package:twofortwo/utils/overlay.dart';

class ItemInfo extends StatefulWidget {
  final int num;
//  final bool vis;
  ItemInfo({this.num});

  @override
  _ItemInfoState createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {

//  OverlayEntry _overlayEntry;


  @override
  Widget build(BuildContext context) {
    var num = widget.num;
    print('in item info');
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black54,width: 3.0)
      ),
      margin: const EdgeInsets.fromLTRB(50.0, 200.0, 50.0, 200.0),
//            position: Offset(offset.dx, offset.dy),
//        color: Colors.white,
      child: Center(
        child: Hero(
          tag: "row$num",
          child: Card(

//            child: Text(
//              'test${widget.num}', style: TextStyle(color: Colors.black),
//            ),
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  Center(child: Text("TODO"))
                  ],
              )

          ),
        ),
      ),

    );

  }
}