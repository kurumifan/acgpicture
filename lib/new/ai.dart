import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget ai() {
  return new Scaffold(
      backgroundColor: Colors.black,
      body: new Center(
        child: new CachedNetworkImage(
          imageUrl: 'http://sixbit.nos-eastchina1.126.net/ayase-min.png',
        ),
      ));
}
