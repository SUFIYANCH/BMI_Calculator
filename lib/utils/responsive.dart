import 'package:flutter/material.dart';

class R {
  static sh(double h, BuildContext context) {
    return MediaQuery.sizeOf(context).height * (h / 812);
  }

  static sw(double w, BuildContext context) {
    return MediaQuery.sizeOf(context).width * (w / 375);
  }
}