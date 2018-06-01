import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import './acg_page.dart';

import './avatar_page.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:xml/xml.dart' as xml;

import '../new/sweethome.dart';

final String appId = Platform.isAndroid
    ? 'ca-app-pub-7280036561880717~1416504824'
    : 'ca-app-pub-7280036561880717~8578563561';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  VoidCallback _showBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: appId);
    _showBottomSheetCallback = _showBottomSheet;
  }

  /// 关于图片
  void _showBottomSheet() {
    setState(() {
      // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
          final ThemeData themeData = Theme.of(context);
          return new Container(
              decoration: new BoxDecoration(
                  border: new Border(
                      top: new BorderSide(color: themeData.disabledColor))),
              child: new Padding(
                  padding: new EdgeInsets.all(32.0),
                  child: new Text('图片均来自网络，如有侵权，请联系删除',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: themeData.accentColor, fontSize: 24.0))));
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              // re-enable the button
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }

  /// 动漫图片 xml接口
  Future<List<String>> getXmlACG() async {
    http.Response response1 = await http.get(
      Uri.encodeFull("https://pics-1256318515.cos.ap-chengdu.myqcloud.com"),
    );
    var keys1 = xml.parse(response1.body).findAllElements('Key');

    return keys1.map((node) => node.text).toList();
  }

  var pics123;
  Widget getXmlACGok(BuildContext context, AsyncSnapshot snapshot) {
    List<String> pics = snapshot.data;
    pics123 = pics.reversed.toList();

    // return new Center(child:new Icon(Icons.departure_board));
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(Icons.insert_emoticon),
        new Icon(Icons.insert_emoticon),
        new Icon(Icons.insert_emoticon)
      ],
    );
  }

  ///头像 xml接口
  Future<List<String>> getXmlAA() async {
    http.Response response2 = await http.get(
      Uri.encodeFull("https://aaaa-1256318515.cos.ap-chengdu.myqcloud.com"),
    );
    var keys2 = xml.parse(response2.body).findAllElements('Key');
    return keys2.map((node) => node.text).toList();
  }

  var aa123;
  Widget getXmlAAok(BuildContext context, AsyncSnapshot snapshot) {
    List<String> aa = snapshot.data;
    aa123 = aa.reversed.toList();
    // return new Center(child:new Icon(Icons.departure_board));
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(Icons.insert_emoticon),
        new Icon(Icons.insert_emoticon),
        new Icon(Icons.insert_emoticon)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ///动漫图片的builder
    var futureBuilderACG = new FutureBuilder(
      future: getXmlACG(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            // return new Icon(Icons.departure_board);
            return new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.departure_board),
                new Icon(Icons.departure_board),
                new Icon(Icons.departure_board)
              ],
            );

          default:
            if (snapshot.hasError) {
              // return new Text('Error: ${snapshot.error}');
              print('${snapshot.error}');
              return new Text('Error');
            } else
              return getXmlACGok(context, snapshot);
        }
      },
    );

    ///头像的builder
    var futureBuilderAA = new FutureBuilder(
      future: getXmlAA(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            // return new Icon(Icons.departure_board);
            return new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.departure_board),
                new Icon(Icons.departure_board),
                new Icon(Icons.departure_board)
              ],
            );

          default:
            if (snapshot.hasError) {
              // return new Text('Error: ${snapshot.error}');
              print('${snapshot.error}');
              return new Text('Error');
            } else
              return getXmlAAok(context, snapshot);
        }
      },
    );

    return new Scaffold(
        key: _scaffoldKey,
        // floatingActionButton: new FlatButton(child: new Text('关于图片',style: new TextStyle(color: Colors.deepOrange,),),onPressed: _showBottomSheetCallback, padding: new EdgeInsetsDirectional.fromSTEB(5.0, 20.0, 5.0, 35.0), ),

        body: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
              new Padding(padding: new EdgeInsets.all(2.0)),

              new Expanded(
                child: new Image.asset('img/acgpics.jpg', scale: 3.0),
              ),

              new Padding(
                padding: new EdgeInsets.all(2.0),
              ),

              new RaisedButton(
                child: new Text(
                  '动漫图片',
                  style: new TextStyle(),
                ),
                color: Colors.blueAccent,
                onPressed: () {
                  pics123 == null
                      ? () {}
                      : Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new AcgPage(imgs: pics123)));
                },
              ),

              //  new Padding(padding: new EdgeInsets.all(0.5)),
              ///横线
              new Divider(),

              new Center(
                child: futureBuilderACG,
              ),

              ///中间一排按钮
              new Row(         
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,        
                children: <Widget>[                  
                  ///甜蜜屋 跳转 按钮
                new RaisedButton(
                  child: new Text('甜蜜屋'),
                  color: Colors.pinkAccent,
                  onPressed: () {  
                       Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new SweetHome()));}
                ),
                ///关于图片 按钮
                  new RaisedButton(
                  child: new Text('关于图片'),
                  color: Colors.deepOrange,
                  onPressed: _showBottomSheetCallback,
                ),
                ///支持一下 按钮
                  new RaisedButton(
                  child: new Text('支持一下'),
                  color: Colors.cyan,
                  onPressed: _showBottomSheetCallback,
                ),
              
                ],
              ),

              ///三个笑脸 代表已经获取到xml
              new Center(
                child: futureBuilderAA,
              ),

              new Divider(),
              // new Padding(padding: new EdgeInsets.all(7.0),),
              new Expanded(
                child: new Image.asset('img/avatarbtn.jpg', scale: 5.0),
              ),

              new Padding(padding: new EdgeInsets.all(2.0)),

              ///头像 按钮
              new RaisedButton(
                child: new Text('头像'),
                color: Colors.blueAccent,
                onPressed: () {
                  pics123 == null
                      ? () {}
                      : Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new AvatarPage(imgs: aa123)));
                },
              ),
              new Padding(padding: new EdgeInsets.all(2.0)),
            ])));
  }
}
