import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';



class AvatarPage extends StatefulWidget {

 final List<String> imgs;

 AvatarPage({Key key,this.imgs}) :super(key:key);
  


  @override
  _AvatarPageState createState() => new _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {

 @override
  Widget build(BuildContext context){
        return new Scaffold(
          body: new Center(
            child: new  GridView.extent(
      maxCrossAxisExtent: 160.0,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: const EdgeInsets.all(4.0),
      children: new List<Widget>.generate(
        widget.imgs.length,
        (a) => new  GestureDetector(
            onTap: (){
            hanldeTap("https://ab16-1256318515.cos.ap-chengdu.myqcloud.com/" +
                    widget.imgs[a]);
          },
          child: new CachedNetworkImage(
                imageUrl: "https://ab16-1256318515.cos.ap-chengdu.myqcloud.com/" +
                    widget.imgs[a],
                placeholder: new CircularProgressIndicator(),
                errorWidget: new Icon(Icons.error),
              ),
        ),
        )
        )
          )
        );
  }

    /// 打开下载页面
  void hanldeTap(String uri) {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
      return new Center(       
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CachedNetworkImage(
                    imageUrl: uri,
                    placeholder: new CircularProgressIndicator(),
                    errorWidget: new Icon(Icons.error),
                  ),
            // new RaisedButton(
            //     onPressed: ()=>handleDownload(uri),
            //     child: new Text('下载')
            // )
            // new FlatButton(
            //   onPressed: ()=>handleDownload(uri),
            //    child: new Icon(Icons.access_alarm),
            // )
          ],
        ),
      );
    }));
  }


} 