import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:xml/xml.dart' as xml;

final String aaaxml = 'https://aaaa-1256318515.cos.ap-chengdu.myqcloud.com/';

class AvatarPage extends StatefulWidget {
  final List<String> imgs;
  AvatarPage({Key key, this.imgs}) : super(key: key);

  @override
  _AvatarPageState createState() => new _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  @override
  void initState() {
    super.initState();
    getXmlAA();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> _avatarlist;

  Future<String> getXmlAA() async {
    http.Response response2 = await http.get(
      Uri.encodeFull(aaaxml),
    );
    setState(() {
      var keys2 = xml.parse(response2.body).findAllElements('Key');
      _avatarlist = keys2.map((node) {
        return node.text;
      }).toList();
    });
    return 'Success!';
  }

  static const MethodChannel platform =
      const MethodChannel('samples.flutter.io/downloadimage');

  @override
  Widget build(BuildContext context) {
    return _avatarlist==null? new Scaffold(
        body: new Center(child: new CircularProgressIndicator()),
      ) :  new Scaffold(
        appBar: new AppBar(
          title: Text('Avatar'),
        ),
        body: new Center(
            child: new GridView.extent(
                maxCrossAxisExtent: 160.0,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: new EdgeInsets.all(4.0),
                children: new List<Widget>.generate(
                  _avatarlist.length,
                  (a) => new GestureDetector(
                        onTap: () {
                          hanldeTap(aaaxml + _avatarlist[a]);
                        },
                        child: new CachedNetworkImage(
                          imageUrl: aaaxml + _avatarlist[a],
                          // placeholder: new CircularProgressIndicator(),
                          placeholder: Image.asset('img/aaloading.jpg'),
                          errorWidget: new Icon(Icons.error),
                        ),
                      ),
                ))));
  }

  /// 打开下载页面
  void hanldeTap(String uri) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new Container(
          color: Colors.white,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Expanded(
                child:  GestureDetector(
                    onDoubleTap: () {
                      Navigator.pop(context);
                    },
                    child:  CachedNetworkImage(
                      imageUrl: uri,
                      placeholder:  Center(child: new CircularProgressIndicator()),
                      errorWidget:  Icon(Icons.error),
                    )),
              ),
              new Padding(
                padding: new EdgeInsets.all(2.0),
              ),
              new RaisedButton(
                child: new Text('下载'),
                onPressed: () {
                  _downloadImage(uri);
                },
              ),
              new Padding(
                padding: new EdgeInsets.all(2.0),
              )
            ],
          ));
    }));
  }

  void _downloadImage(String url) {
    platform.invokeMethod('downloadImage', url);
  }
}
