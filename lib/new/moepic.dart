import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget moepic() {
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
          imageUrl: 'https://files.yande.re/sample/eb92f9b590ab882c4a1b5cee05dad305/yande.re%20455798%20sample%20animal_ears%20bikini_armor%20djibril%20no_game_no_life%20tagme%20tattoo%20thighhighs%20wings.jpg',
          fadeInDuration:  Duration(seconds: 3),
          fit: BoxFit.cover,
        ),
      ));
}
