import 'package:flutter/material.dart';

import './acg_page.dart';

import './avatar_page.dart';

import '../new/sweethome.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
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
                  
                       Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new AcgPage()));
                },
              ),

              //  new Padding(padding: new EdgeInsets.all(0.5)),
              ///横线
              new Divider(),

              

              ///中间一排按钮
              new Row(         
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,        
                children: <Widget>[                  
                  ///甜蜜屋 跳转 按钮
                new Expanded(
                                  child: new RaisedButton(
                    child: new Text('甜蜜屋'),
                    color: Colors.pinkAccent,
                    onPressed: () {  
                         Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new SweetHome()));}
                  ),
                ),
                ///关于图片 按钮
                  new Expanded(
                                      child: new RaisedButton(
                    child: new Text('关于图片'),
                    color: Colors.deepOrange,
                    onPressed: _showBottomSheetCallback,
                ),
                  ),
                ///支持一下 按钮
                  new Expanded(
                                      child: new RaisedButton(
                    child: new Text('支持一下'),
                    color: Colors.cyan,
                    onPressed: _showBottomSheetCallback,
                ),
                  ),
              
                ],
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
                  
                      Navigator.of(context).push(new MaterialPageRoute(                       
                          builder: (BuildContext context) =>
                              new AvatarPage()));
                },
              ),
              new Padding(padding: new EdgeInsets.all(2.0)),
            ])));
  }
}

