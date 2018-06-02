import 'package:flutter/material.dart';


///个人信息 页面
Widget myinfo(BuildContext covariant) {
  return new Column(
    children: <Widget>[
      new Padding(
        padding: EdgeInsets.all(15.0),
      ),
      new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
            top: new BorderSide(color: new Color(0xFFBCBBC1), width: 0.0),
            bottom: new BorderSide(color: new Color(0xFFBCBBC1), width: 0.0),
          ),
        ),
        height: 150.0,
        child: new Padding(
          padding: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: new SafeArea(
            top: false,
            bottom: false,
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: new GestureDetector(
                        onTap: () {
                          Navigator.of(covariant).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new AvatarScreen()));
                        },
                        child: new Hero(
                          tag: 'avatarhero',
                          child: new Image.network(
                              'http://sixbit.nos-eastchina1.126.net/303-min.jpg'),
                        ))),
                new Padding(
                  padding: EdgeInsets.all(3.0),
                ),
                new Expanded(
                  child: new ListTile(
                    onTap: () {
                      print('哇，onTap');
                     setState(){
                       var a =1;
                     }
                    },
                    title: new Text('赤座灯里'),
                    subtitle: new Text(
                      '\n存在感爆表的女主角',
                      style: new TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

///点开头像
class AvatarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Stack(children: <Widget>[
      new SafeArea(
          child: GestureDetector(
        child: new Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 50.0,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      )),
      new GestureDetector(
        child: new Hero(           
          tag: 'avatarhero',
          child: new Center(
              child: new Image.network(
            'http://sixbit.nos-eastchina1.126.net/303-min.jpg',
          )),
        ),
      )
    ]);
  }
}
