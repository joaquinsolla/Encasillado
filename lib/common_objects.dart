import 'package:flutter/material.dart';

import 'my_database.dart';

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