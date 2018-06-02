import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/services.dart';

import 'ad_page.dart';



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
    bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    myBanner?.dispose();
    super.dispose();
  }

 static const MethodChannel platform =
      const MethodChannel('samples.flutter.io/downloadimage');

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
          bannerAd?.dispose();
          bannerAd = null;
          Navigator.pop(context);
        },
        child: new Scaffold(
          appBar: new AppBar(),
            body: new Center(
                child: new GridView.extent(
                    maxCrossAxisExtent: 160.0,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    padding: new EdgeInsets.all(4.0),
                    children: new List<Widget>.generate(
                      widget.imgs.length,
                      (a) => new GestureDetector(
                            onTap: () {
                              hanldeTap(aaaxml + widget.imgs[a]);
                              bannerAd?.dispose();
                              bannerAd = null;
                            },
                            child: new CachedNetworkImage(
                              imageUrl: aaaxml + widget.imgs[a],
                              // placeholder: new CircularProgressIndicator(),
                              placeholder: Image.asset('img/aaloading.jpg'),
                              errorWidget: new Icon(Icons.error),
                            ),
                          ),
                    )))));
  }

  /// 打开下载页面
  void hanldeTap(String uri) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new WillPopScope(
          onWillPop: () {
            bannerAd ??= createBannerAd();
            bannerAd
              ..load()
              ..show();
            Navigator.pop(context);
          },
          child: new Container(
              color: Colors.white,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                      onDoubleTap: (){Navigator.pop(context);},
                     child: new CachedNetworkImage(
                      imageUrl: uri,
                      placeholder: new CircularProgressIndicator(),
                      errorWidget: new Icon(Icons.error),
                     )
                    ),
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
              )));
    }));
  }

  void _downloadImage(String url) {
   platform.invokeMethod('downloadImage', url);
  }
}
