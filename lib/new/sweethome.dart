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
        appBar: new AppBar(
          automaticallyImplyLeading: true,
          title: new Text('${_titles[_currentIndex]}'),
          centerTitle: true,
          backgroundColor: _colors[_currentIndex],
        ),
        bottomNavigationBar: botNavBar,
        body: new Builder(
          builder: (BuildContext covariant) {
            switch (_currentIndex) {
              case 0:
                return new Scaffold(
                    backgroundColor: Colors.black,
                    body: new Center(
                      child: new CachedNetworkImage(
                        imageUrl:
                            'http://sixbit.nos-eastchina1.126.net/ayase-min.png',
                      ),
                    ));

              case 1:
                return new Scaffold(
                  appBar: new AppBar(
                    title: new Text('这是什么鬼'),
                  ),
                  body: new Image.network(
                      'http://optimizilla.com/images/optimizilla/logo.png'),
                );

              case 2:
                return new Container(
                    height: 2000.0,
                    width: 2000.0,
                    child: new GestureDetector(
                      onLongPress: () {
                        print('这是长按');
                      },
                      child: new CachedNetworkImage(
                        errorWidget: new Icon(Icons.error),
                        placeholder: new Icon(Icons.save),
                        imageUrl: 'http://sixbit.nos-eastchina1.126.net/3.png',
                        fadeInDuration: new Duration(seconds: 3),
                        fit: BoxFit.cover,
                      ),
                    ));

              case 3:
                return myinfo();

              default:
                return new Center();
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
