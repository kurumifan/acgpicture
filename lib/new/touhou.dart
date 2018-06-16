import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget touhou() {
  return new Container(
      height: 2000.0,
      width: 2000.0,
      child:  GestureDetector(
        onLongPress: () {
          print('这是长按');
        },
        child:  CachedNetworkImage(
          errorWidget:  Icon(Icons.error),
          placeholder:  Icon(Icons.save),
          imageUrl: 'http://sixbit.nos-eastchina1.126.net/3.png',
          fadeInDuration:  Duration(seconds: 3),
          fit: BoxFit.cover,
        ),
      ));
}
