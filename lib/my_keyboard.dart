import 'package:flutter/material.dart';

import 'common.dart';
import 'init_view.dart';


SizedBox my_letter_key(String char){
  return SizedBox(
    height: (devWidth/6),
    width: (devWidth/10),
    child: TextButton(
      child: Text(char),
      style: TextButton.styleFrom(primary: Colors.grey, backgroundColor: Colors.white),
      onPressed: () {
        if (canWrite){
          lettersArray[currentCell] = char;
          currentCell++;
          if (currentCell == 5 || currentCell == 10 || currentCell == 15 || currentCell == 20 || currentCell == 25) {canWrite = false;}
        }
        runApp(MyApp());
      },
    ),
  );
}

SizedBox my_enter_key(BuildContext context){
  return SizedBox(
    height: (devWidth/6),
    width: (devWidth/5),
    child: TextButton(
      child: const Text("PROBAR"),
      style: TextButton.styleFrom(primary: Colors.grey, backgroundColor: Colors.white),
      onPressed: () {
        if (currentCell == 5 || currentCell == 10 || currentCell == 15 || currentCell == 20 || currentCell == 25){
          if (check_word()){
            victoryDialog(context);
          } else {
            currentRow++;
            canWrite = true;
          }
        }
        runApp(MyApp());
      },
    ),
  );
}

SizedBox my_backspace_icon(){
  return SizedBox(
    height: (devWidth/6),
    width: (devWidth/10),
    child: IconButton(
      icon: const Icon(Icons.keyboard_backspace),
      onPressed: () {
        if (currentCell == 0 || (currentCell == 5 && canWrite == true) || (currentCell == 10 && canWrite == true) ||
            (currentCell == 15 && canWrite == true) || (currentCell == 20 && canWrite == true)){}
        else {
          currentCell--;
          lettersArray[currentCell] = "";
          canWrite = true;
        }
        runApp(MyApp());
      },
    ),
  );
}

Column generate_keyboard(BuildContext context){
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
        my_enter_key(context),
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

bool check_word(){
  String input_word = lettersArray[currentRow*5]+lettersArray[currentRow*5+1]+
      lettersArray[currentRow*5+2]+lettersArray[currentRow*5+3]+lettersArray[currentRow*5+4];

  print("hint->" + wordOfTheDay);
  return (input_word == wordOfTheDay);
}