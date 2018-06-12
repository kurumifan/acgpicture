import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'ai.dart';
import 'moepic.dart';
import 'myinfo.dart';
import 'touhou.dart';

class SweetHome extends StatefulWidget {
  @override
  _SweetHomeState createState() => new _SweetHomeState();
}

class _SweetHomeState extends State<SweetHome> {
  List<NavigationIconView> _navigationViews;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();    
  }


  @override
  Widget build(BuildContext context) {
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.font_download),
        title: '伪AI',
        color: Colors.pink,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.image),
        title: '二次元',
        color: Colors.deepOrange,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.linked_camera),
        title: '东方',
        color: Colors.red,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.account_box),
        title: '我的',
        color: Colors.blueAccent,
      ),
    ];

    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );

    List<String> _titles = ['学生会长', '萌妹纸', '幻想乡', '个人信息'];
    List<Color> _colors = [
      Colors.pinkAccent,
      Colors.deepOrange,
      Colors.redAccent,
      Colors.blue
    ];
    return new WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: new Scaffold(
        appBar: new PreferredSize(
         
            preferredSize: new Size(10.0, 50.0),
            child: new AppBar(
              automaticallyImplyLeading: true,
          title: new Text('${_titles[_currentIndex]}'),
          centerTitle: true,
          backgroundColor: _colors[_currentIndex],
            )
          
          
        ),
        bottomNavigationBar: botNavBar,
        body: new Builder(
          builder: (BuildContext covariant) {
            switch (_currentIndex) {
              case 0:              
                return ai();
                
                break;
              case 1:
                return moepic();                
                break;
              case 2:
                return touhou();
                break;
              case 3:
                return myinfo(context);
                break;
              default:
                return new Center(
                  child: new Text(
                    '页面不见了',
                    style: new TextStyle(fontSize: 30.0,color:Colors.red),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    String title,
    Color color,
  })  : _icon = icon,
        _color = color,
        _title = title,
        item = new BottomNavigationBarItem(
          icon: icon,
          title: new Text(title),
          backgroundColor: color,
        );

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
}
