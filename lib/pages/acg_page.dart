import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:xml/xml.dart' as xml;
import 'package:cached_network_image/cached_network_image.dart';


class AcgPage extends StatefulWidget {
  @override
  _AcgPageState createState() => new _AcgPageState();
}

class _AcgPageState extends State<AcgPage> {

  /// 下载
  void handleDownload(String uri) {
    print('下载 $uri');
  }

  /// 打开下载页面
  void hanldeTap(String uri) {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
      return new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CachedNetworkImage(
                    imageUrl: uri,
                    placeholder: new CircularProgressIndicator(),
                    errorWidget: new Icon(Icons.error),
                  ),
            new RaisedButton(
                onPressed: ()=>handleDownload(uri),
                child: new Text('下载')
            )
          ],
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: getXml(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');

          default:
            if (snapshot.hasError){
              // return new Text('Error: ${snapshot.error}');
              print('${snapshot.error}');
              return new Text('Error');}
            else
              return createListImage(context, snapshot);
        }
      },
    );

    return new Scaffold(body: new Center(child: futureBuilder));
  }

  Widget createListImage(BuildContext context, AsyncSnapshot snapshot) {
    List<String> eee = snapshot.data;
    return new GridView.extent(
      maxCrossAxisExtent: 160.0,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: const EdgeInsets.all(4.0),
      children: new List<Widget>.generate(
        eee.length,
        (a) => new GestureDetector(
          onTap: (){
            hanldeTap("https://ab16-1256318515.cos.ap-chengdu.myqcloud.com/" +
                    eee[a]);
          },
          child: new CachedNetworkImage(
                imageUrl: "https://ab16-1256318515.cos.ap-chengdu.myqcloud.com/" +
                    eee[a],
                placeholder: new CircularProgressIndicator(),
                errorWidget: new Icon(Icons.error),
              ),
        ),
      ),
    );
  }

  Future<List<String>> getXml() async {
    http.Response response = await http.get(
      Uri.encodeFull("https://ab16-1256318515.cos.ap-chengdu.myqcloud.com"),
    );

    var keys = xml.parse(response.body).findAllElements('Key');
    print('成功获取xml');

    return keys.map((node) => node.text).toList();

  }
}
