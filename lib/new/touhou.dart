import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget touhou() {
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
}
