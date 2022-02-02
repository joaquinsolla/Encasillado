import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';

List <String> wordsList = [];

/** VARIABLES */
// Device size
double devHeight = 0;
double devWidth = 0;

// Cell control
int currentCell = 0;
int currentRow = 0;
bool canWrite = true;
bool finished = false;

// Array of content of cells
List <String> inputMatrix = ["","","","","",   "","","","","",   "","","","","",   "","","","","",   "","","","","",   "","","","",""];
List <String> colorsArray = ["B","B","B","B","B",   "B","B","B","B","B",   "B","B","B","B","B",   "B","B","B","B","B",   "B","B","B","B","B",   "B","B","B","B","B"];

// Word of the day
List <String> wordOfTheDay = ["","","","",""];


/** METHODS & WIDGETS */

AppBar MainAppBar() {
  return AppBar(
    backgroundColor: Color(0xff009688),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('app_files/my_logo.png'),
      ],
    ),
  );
}

AnimatedContainer letterCell(String char, String col){

  //COLOR SELECTION
  Color? cellColor = Colors.white;
  if (col == "V") cellColor = Colors.green;
  if (col == "A") cellColor = Colors.yellow;
  if (col == "G") cellColor = Colors.grey;

  return AnimatedContainer(
    duration: Duration(milliseconds: 750),
    curve: Curves.easeInOutCirc,
    width: (devWidth/5 - 10.0),
    height: (devWidth/5 - 10.0),
    margin: const EdgeInsets.fromLTRB(2.0,6.0,2.0,6.0),
    padding: const EdgeInsets.all(0.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: cellColor,
      border: Border.all(color: Colors.black54, width: 3.0),
    ),
    child: Text(char, style: TextStyle(fontSize: 45.0, color: Colors.black),),
  );
}

Row letterRow(int _from){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      letterCell(inputMatrix[_from], colorsArray[_from]),
      letterCell(inputMatrix[_from+1], colorsArray[_from+1]),
      letterCell(inputMatrix[_from+2], colorsArray[_from+2]),
      letterCell(inputMatrix[_from+3], colorsArray[_from+3]),
      letterCell(inputMatrix[_from+4], colorsArray[_from+4]),
    ],
  );
}

Column cellsField() {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10.0,),
        letterRow(0),
        letterRow(5),
        letterRow(10),
        letterRow(15),
        letterRow(20),
        letterRow(25),
      ]);
}

void word_doesnt_exist_snackbar(BuildContext context) {
  //may cause problems with null sound safety
  Flushbar(
    message: "La palabra no existe",
    duration: Duration(seconds: 3),
    backgroundColor: Colors.redAccent,
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}

void victory_dialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Center(
          child: Container(
            height: devHeight * 0.8,
            width: devWidth * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(height: 15,),
              SizedBox(height: 90, child: Image.asset('app_files/trophy.png'),),
              SizedBox(height: 15,),
              Text("VICTORIA", style: TextStyle(fontSize: 30, color: Colors.black, decoration: null, ),),

              ],),
          )
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

void defeat_dialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Center(
          child: Container(
            height: devHeight * 0.8,
            width: devWidth * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15,),
                SizedBox(height: 90, child: Image.asset('app_files/defeat.png'),),
                SizedBox(height: 15,),
                Text("DERROTA", style: TextStyle(fontSize: 30, color: Colors.black, decoration: null, ),),

              ],),
          )
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}