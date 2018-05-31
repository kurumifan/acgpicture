import 'package:flutter/material.dart';

Widget myinfo() {
  return new Column(
    children: <Widget>[
      new Padding(padding: EdgeInsets.all(15.0),),
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
                      children:<Widget>[
                        new Expanded(
                          child:new Image.network('http://sixbit.nos-eastchina1.126.net/303-min.jpg'),
                        ),
                      
                        new Padding(padding: EdgeInsets.all(3.0),),    

                        new Expanded(
                          child: new ListTile(   
                            onTap: (){print('这玩意居然有onTap');},                         
                            title:new Text('赤座灯里'),
                            subtitle: new Text('\n存在感爆表的女主角',style: new TextStyle(color: Colors.grey),),
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
