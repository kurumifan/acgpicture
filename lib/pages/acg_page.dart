import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/services.dart';


import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:xml/xml.dart' as xml;

final String picsxml = "https://pics-1256318515.cos.ap-chengdu.myqcloud.com/";

class AcgPage extends StatefulWidget {
  final List<String> imgs;

  AcgPage({Key key, this.imgs}) : super(key: key);

  @override
  _AcgPageState createState() => new _AcgPageState();
}

class _AcgPageState extends State<AcgPage> {



  @override
  void initState() {
    super.initState();
    getXmlPics();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> _picslist;

  Future<String> getXmlPics() async {
    http.Response response2 = await http.get(
      Uri.encodeFull(picsxml),
    );
    setState(() {
      var keys2 = xml.parse(response2.body).findAllElements('Key');
      _picslist = keys2.map((node) {
        return node.text;
      }).toList();
    });
    return 'Success!';
  }


  static const platform =
      const MethodChannel('samples.flutter.io/downloadimage');

  /// 打开下载页面
  void hanldeTap(String uri) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new Container(
          color: Colors.white,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Expanded(
                child:  GestureDetector(
                  onDoubleTap: () {
                    Navigator.pop(context);
                  },
                  child:  CachedNetworkImage(
                    imageUrl: uri,
                    placeholder:  Center(child:  CircularProgressIndicator()),
                    errorWidget:  Icon(Icons.error),
                  ),
                ),
              ),
               Padding(
                padding:  EdgeInsets.all(2.0),
              ),
              new  RaisedButton(
                child:  Text('下载'),
                onPressed: () {
                  _downloadImage(uri);
                },
              ),
               Padding(
                padding:  EdgeInsets.all(2.0),
              )
            ],
          ));
    }));
  }

  void _downloadImage(String url) {
    platform.invokeMethod('downloadImage', url);
  }

  @override
  Widget build(BuildContext context) {
      return _picslist==null? new Scaffold(
        body: new Center(child: new CircularProgressIndicator()),
      ) : new Scaffold(
        appBar: new AppBar(
          title: Text('Picture'),
        ),
        body: new Center(
            child: new GridView.extent(
                maxCrossAxisExtent: 160.0,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: new EdgeInsets.all(4.0),
                children: new List<Widget>.generate(
                  _picslist.length,
                  (a) => new GestureDetector(
                      onTap: () {
                        hanldeTap(picsxml + _picslist[a]);
                      },
                      child: new CachedNetworkImage(
                        imageUrl: picsxml + _picslist[a],
                        // placeholder: new CircularProgressIndicator(),
                        placeholder: new Image.asset('img/picloading.jpg'),
                        errorWidget: new Icon(Icons.error),
                      )),
                ))));
  }
}

