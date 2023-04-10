import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class IsSuccess {
  void fluttertoast() {
    Fluttertoast.showToast(
        msg: "No Internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
