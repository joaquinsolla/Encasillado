import 'package:flutter/material.dart';


/** VARIABLES */
// Device size
double devHeight = 0;
double devWidth = 0;

// Cell control
int currentCell = 0;
int currentRow = 0;
bool canWrite = true;

// Array of content of cells
List <String> lettersArray = ["","","","","",   "","","","","",   "","","","","",   "","","","","",   "","","","","",   "","","","",""];

// Word of the day
String wordOfTheDay = "";


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

Container letterCell(String char){
  return Container(
    width: (devWidth/5 - 10.0),
    height: (devWidth/5 - 10.0),
    margin: const EdgeInsets.fromLTRB(2.0,6.0,2.0,6.0),
    padding: const EdgeInsets.all(0.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
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
      letterCell(lettersArray[_from]),
      letterCell(lettersArray[_from+1]),
      letterCell(lettersArray[_from+2]),
      letterCell(lettersArray[_from+3]),
      letterCell(lettersArray[_from+4]),
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

void victoryDialog(BuildContext context) {
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