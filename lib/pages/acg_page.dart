import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:xml/xml.dart' as xml;
import 'package:cached_network_image/cached_network_image.dart';


class AcgPage extends StatefulWidget {

final List<String> imgs;

 AcgPage({Key key, this.imgs}) : super(key:key);
  
  @override
  _AcgPageState createState() => new _AcgPageState();
}



class _AcgPageState extends State<AcgPage> {


  /// 下载
  void handleDownload(String uri) {
    print('下载 $uri');

 
  }

    /// 打开下载页面
  void hanldeTap(String uri) {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
      return new Container(   
        color: Colors.white,

         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            new Expanded(child: 
            new GestureDetector(
              onTap:(){ Offset(3.0,30.0);print('123');},
              // onScaleUpdate: ,
              child: new CachedNetworkImage(
                    imageUrl: uri,
                    placeholder: new CircularProgressIndicator(),
                    errorWidget: new Icon(Icons.error),
                  ), ), ),

                new Padding(padding: new EdgeInsets.all(2.0),),
                  new RaisedButton(
                    child: new Text('下载'),
                    onPressed:abc,
                  ),
               new Padding(padding: new EdgeInsets.all(2.0),)
          ],
         )
      );
    }));
  }

void abc(){
  print('暂时不知道怎么下载');
}


 @override
  Widget build(BuildContext context){
        return new Scaffold(
          body: new Center(
            child: new  GridView.extent(
      maxCrossAxisExtent: 160.0,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: const EdgeInsets.all(4.0),
      children: new List<Widget>.generate(
        widget.imgs.length,
        (a) => new  GestureDetector(
            onTap: (){
            hanldeTap("https://ab16-1256318515.cos.ap-chengdu.myqcloud.com/" +
                    widget.imgs[a]);
          },
          child: new CachedNetworkImage(
                imageUrl: "https://ab16-1256318515.cos.ap-chengdu.myqcloud.com/" +
                    widget.imgs[a],
                placeholder: new CircularProgressIndicator(),
                errorWidget: new Icon(Icons.error),
              ),
        ),
        )
        )
          )
        );
  }
}