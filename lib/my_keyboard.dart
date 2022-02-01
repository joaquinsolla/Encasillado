import 'package:flutter/material.dart';

import 'my_database.dart';


SizedBox my_letter_key(String char){
  return SizedBox(
    height: (devWidth/6),
    width: (devWidth/10),
    child: TextButton(
      child: Text(char),
      style: TextButton.styleFrom(primary: Colors.grey, backgroundColor: Colors.white),
      onPressed: () {/** TO DO . . . */},
    ),
  );
}

SizedBox my_enter_key(){
  return SizedBox(
    height: (devWidth/6),
    width: (devWidth/5),
    child: TextButton(
      child: const Text("PROBAR"),
      style: TextButton.styleFrom(primary: Colors.grey, backgroundColor: Colors.white),
      onPressed: () {/** TO DO . . . */},
    ),
  );
}

SizedBox my_backspace_icon(){
  return SizedBox(
    height: (devWidth/6),
    width: (devWidth/10),
    child: IconButton(
      icon: const Icon(Icons.keyboard_backspace),
      onPressed: () {/** TO DO . . . */},
    ),
  );
}

Column generate_keyboard(){
  return Column(children: [
      //ROW 1
      Row(children: [
        my_letter_key("Q"),
        my_letter_key("W"),
        my_letter_key("E"),
        my_letter_key("R"),
        my_letter_key("T"),
        my_letter_key("Y"),
        my_letter_key("U"),
        my_letter_key("I"),
        my_letter_key("O"),
        my_letter_key("P"),
      ],),

      //ROW 2
      Row(children: [
        my_letter_key("A"),
        my_letter_key("S"),
        my_letter_key("D"),
        my_letter_key("F"),
        my_letter_key("G"),
        my_letter_key("H"),
        my_letter_key("J"),
        my_letter_key("K"),
        my_letter_key("L"),
        my_letter_key("Ñ"),
      ],),

      //ROW 3
      Row(children: [
        my_enter_key(),
        my_letter_key("Z"),
        my_letter_key("X"),
        my_letter_key("C"),
        my_letter_key("V"),
        my_letter_key("B"),
        my_letter_key("N"),
        my_letter_key("M"),
        my_backspace_icon(),
      ],),
    ],
  );
}