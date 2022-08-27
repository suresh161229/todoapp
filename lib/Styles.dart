import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class Styles {
  static  TextStyle textStyle18 = GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold));
  static  TextStyle textStyle15black = GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold));
  static  TextStyle textStyle30 = GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.bold));
  static  TextStyle textStyle18grey = GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 18, color: Colors.grey,fontWeight: FontWeight.bold));
  static  TextStyle textStyle15grey = GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 18, color: Colors.grey));
  static  TextStyle textStyle15 = GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 15, color: Colors.white));
  static  TextStyle errorstyle = GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 15, color: Colors.red));
  static  TextStyle fieldstyle = GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 12, color: Colors.black));
  static  TextStyle fieldstylegrey = GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 12, color: Colors.grey));

}
const btnColor = Colors.blue;
const bgColor = Colors.indigo;
const borderColor = Colors.grey;
const errorColor = Colors.red;
const successClr = Colors.green;

class Clr{
  static Color grey = Colors.grey;
  static Color white = Colors.white;
  static Color blue = Colors.blue;
  static Color lightblue = Colors.lightBlue;
  static Color lightgreen = Colors.lightGreen;
  static Color red = Colors.red;
}
class ToastMessage{
  static successToast(msg){
    return  Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: successClr,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  static errorToast(msg){
    return  Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: errorColor,
        textColor: Colors.black,
        fontSize: 16.0
    );

  }
}