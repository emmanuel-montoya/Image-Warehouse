import 'package:flutter/material.dart';

class ImageWarehouseAppTheme {

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static const boxDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.indigo,
        Colors.indigoAccent
      ] ,
      begin: FractionalOffset.topRight,
      end: FractionalOffset.bottomLeft,
    ),
  );

  static const Size appBarHeight = Size.fromHeight(50.0);
  static const double padding10 = 10.0;
  static const double padding20 = 20.0;
  static const SizedBox heightSpace10 = SizedBox(height: 10);
  static const SizedBox heightSpace20 = SizedBox(height: 20);

}

