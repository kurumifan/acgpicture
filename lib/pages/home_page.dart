import 'package:flutter/material.dart';

import './acg_page.dart';

import './avatar_page.dart';


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

  void _showBottomSheet() {
    setState(() { // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
      final ThemeData themeData = Theme.of(context);
      return new Container(
        decoration: new BoxDecoration(
          border: new Border(top: new BorderSide(color: themeData.disabledColor))
        ),
        child: new Padding(
          padding: const EdgeInsets.all(32.0),
          child: new Text('图片均来自网络，如有侵权，请联系删除',
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: themeData.accentColor,
              fontSize: 24.0
            )
          )
        )
      );
    })
    .closed.whenComplete(() {
      if (mounted) {
        setState(() { // re-enable the button
          _showBottomSheetCallback = _showBottomSheet;
        });
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      floatingActionButton: new FlatButton(child: new Text('关于图片',style: new TextStyle(color: Colors.deepOrange,),),onPressed: _showBottomSheetCallback, padding: new EdgeInsetsDirectional.fromSTEB(5.0, 20.0, 5.0, 35.0), ),
            body: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset('img/avatarbtn.jpg',scale: 3.0),
            new Padding(padding: new EdgeInsets.all(6.0)),
            new RaisedButton(
              child: new Text('动漫图片',style: new TextStyle(),),
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new AcgPage()));
              },
            ),
            new Padding(padding: new EdgeInsets.all(7.0),),
            new Image.asset('img/acgpics.png', scale: 5.0),
            new Padding(padding: new EdgeInsets.all(6.0)),
           
            
            
                new RaisedButton(
                child: new Text('头像'),
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new MyHomePage()));
                },
            ),
             
          ]
       
     ) ));
  }
}
