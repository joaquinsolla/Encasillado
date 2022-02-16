import 'package:flutter/material.dart';

import 'common_imagepaths.dart';
import 'common_pages.dart';
import 'common_variables.dart';
import 'common_widgets.dart';
import 'common_colors.dart';
import 'main_view.dart';


List<String> greenKeys = [];
List<String> yellowKeys = [];
List<String> greyKeys = [];

SizedBox my_letter_key(String char) {
  Color? mycolor = keyColor;

  for (var i = 0; i < greenKeys.length; i++) {
    if (char == greenKeys[i]) {
      mycolor = myGreen;
    }
  }
  if (mycolor == keyColor) {
    for (var i = 0; i < yellowKeys.length; i++) {
      if (char == yellowKeys[i]) {
        mycolor = myYellow;
      }
    }
  }
  if (mycolor == keyColor) {
    for (var i = 0; i < greyKeys.length; i++) {
      if (char == greyKeys[i]) {
        mycolor = myGrey;
      }
    }
  }

  return SizedBox(
    height: keyHeight,
    width: (deviceWidth / 10),
    child: Container(
      margin: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
      child: TextButton(
        child: Text(char),
        style: TextButton.styleFrom(
          primary: myBlack,
          backgroundColor: mycolor,
        ),
        onPressed: () {
          if (!finished) {
            if (canWrite) {
              inputMatrix[currentCell] = char;
              currentCell++;
              if (currentCell == 5 ||
                  currentCell == 10 ||
                  currentCell == 15 ||
                  currentCell == 20 ||
                  currentCell == 25 ||
                  currentCell == 30) {
                canWrite = false;
              }
            }
            runApp(EncasilladoApp());
          }
        },
      ),
    ),
  );
}

SizedBox my_enter_key(BuildContext context) {
  return SizedBox(
    height: keyHeight,
    width: (deviceWidth / 5),
    child: Container(
      margin: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
      child: TextButton(
        child: const Text("PROBAR", style: TextStyle(fontSize: 12),),
        style:
            TextButton.styleFrom(primary: myBlack, backgroundColor: keyColor),
        onPressed: () {
          if ((currentCell == 5 ||
                  currentCell == 10 ||
                  currentCell == 15 ||
                  currentCell == 20 ||
                  currentCell == 25 ||
                  currentCell == 30) &&
              canWrite == false) {
            if (word_exists()) {
              if (correct_word()) {
                if (!finished) {
                  if (currentPage == 0) {
                    finished = true;
                    wonGame = true;
                    wotdDone = true;
                  }
                  if (currentPage == 1) {
                    streak++;
                    finished = true;
                    wonGame = true;
                  }

                }
                if (currentPage == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const word_of_the_day_finished_page()));
                }
                if (currentPage == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const palabras_infinitas_finished_page()));
                }
              } else {
                if (currentCell == 30) {
                  if (!finished) {
                    if (currentPage == 0) {
                      finished = true;
                      wonGame = false;
                      wotdDone = true;
                    }
                    if (currentPage == 1) {
                      streak=0;
                      finished = true;
                      wonGame = false;
                    }
                  }
                  if (currentPage == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const word_of_the_day_finished_page()));
                  }
                  if (currentPage == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const palabras_infinitas_finished_page()));
                  }
                } else {
                  currentRow++;
                  canWrite = true;
                }
              }
            } else {
              word_doesnt_exist_snackbar(context);
            }
          }
          if (finished) {
            endDate = DateTime.now();
            playSeconds = endDate.difference(startDate);
          }
          runApp(EncasilladoApp());
        },
      ),
    ),
  );
}

SizedBox my_backspace_icon() {
  Color? mycolor = keyColor;
  if (darkMode) {
    return SizedBox(
      height: keyHeight,
      width: (deviceWidth / 10),
      child: Container(
        margin: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: mycolor,
          ),
          child: Image.asset(backspace_icon_darkmode),
          onPressed: () {
            if (!finished) {
              if (currentCell == 0 ||
                  (currentCell == 5 && canWrite == true) ||
                  (currentCell == 10 && canWrite == true) ||
                  (currentCell == 15 && canWrite == true) ||
                  (currentCell == 20 && canWrite == true) ||
                  (currentCell == 25 && canWrite == true)) {
              } else {
                currentCell--;
                inputMatrix[currentCell] = "";
                canWrite = true;
              }
              runApp(EncasilladoApp());
            }
          },
        ),
      ),
    );
  } else {
    return SizedBox(
      height: keyHeight,
      width: (deviceWidth / 10),
      child: Container(
        margin: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: mycolor,
          ),
          child: Image.asset(backspace_icon),
          onPressed: () {
            if (!finished) {
              if (currentCell == 0 ||
                  (currentCell == 5 && canWrite == true) ||
                  (currentCell == 10 && canWrite == true) ||
                  (currentCell == 15 && canWrite == true) ||
                  (currentCell == 20 && canWrite == true) ||
                  (currentCell == 25 && canWrite == true)) {
              } else {
                currentCell--;
                inputMatrix[currentCell] = "";
                canWrite = true;
              }
              runApp(EncasilladoApp());
            }
          },
        ),
      ),
    );
  }
}

Column generate_keyboard(BuildContext context) {
  return Column(
    children: [
      //ROW 1
      Row(
        children: [
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
        ],
      ),

      //ROW 2
      Row(
        children: [
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
        ],
      ),

      //ROW 3
      Row(
        children: [
          my_enter_key(context),
          my_letter_key("Z"),
          my_letter_key("X"),
          my_letter_key("C"),
          my_letter_key("V"),
          my_letter_key("B"),
          my_letter_key("N"),
          my_letter_key("M"),
          my_backspace_icon(),
        ],
      ),
    ],
  );
}

bool correct_word() {

  String selectedWordString = standardWordString;
  List <String> selectedWordArray = standardWordArray;
  if (currentPage == 0) {
    selectedWordString = wordOfTheDayString;
    selectedWordArray = wordOfTheDayArray;
  }

  String inputWord = inputMatrix[currentRow * 5] +
      inputMatrix[currentRow * 5 + 1] +
      inputMatrix[currentRow * 5 + 2] +
      inputMatrix[currentRow * 5 + 3] +
      inputMatrix[currentRow * 5 + 4];

  List<String> correctLetterByLetter = ["", "", "", "", ""];
  for (var i = 0; i < 5; i++) {
    correctLetterByLetter[i] = selectedWordArray[i];
  }

  List<String> inputLetterByLetter = ["-", "-", "-", "-", "-"];
  for (var i = 0; i < 5; i++) {
    inputLetterByLetter[i] = inputMatrix[currentRow * 5 + i];
  }

  if (inputWord == selectedWordString) {
    colorsArray[currentRow * 5 + 0] = "V";
    colorsArray[currentRow * 5 + 1] = "V";
    colorsArray[currentRow * 5 + 2] = "V";
    colorsArray[currentRow * 5 + 3] = "V";
    colorsArray[currentRow * 5 + 4] = "V";

    for (var i = 0; i < 5; i++) {
      greenKeys.insert(0, selectedWordArray[i]);
    }

    return true;
  } else {
    //GREEN
    for (var i = 0; i < 5; i++) {
      if (inputMatrix[currentRow * 5 + i] == selectedWordArray[i]) {
        colorsArray[currentRow * 5 + i] = "V";
        greenKeys.insert(0, inputMatrix[currentRow * 5 + i]);
        correctLetterByLetter[i] = "";
        inputLetterByLetter[i] = "-";
      }
    }
    //YELLOW
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        if (inputLetterByLetter[i] == correctLetterByLetter[j] &&
            inputLetterByLetter[i] != "-" &&
            correctLetterByLetter[j] != "") {
          colorsArray[currentRow * 5 + i] = "A";
          yellowKeys.insert(0, inputLetterByLetter[i]);
          correctLetterByLetter[j] = "";
          inputLetterByLetter[i] = "-";
        }
      }
    }
    //GREY
    for (var i = 0; i < 5; i++) {
      if (inputLetterByLetter[i] != "-") {
        colorsArray[currentRow * 5 + i] = "G";
        greyKeys.insert(0, inputLetterByLetter[i]);
      }
    }
    return false;
  }
}

bool word_exists() {
  String inputWord = inputMatrix[currentRow * 5] +
      inputMatrix[currentRow * 5 + 1] +
      inputMatrix[currentRow * 5 + 2] +
      inputMatrix[currentRow * 5 + 3] +
      inputMatrix[currentRow * 5 + 4];

  for (var i = 0; i < selectedDatabase.length; i++) {
    if (inputWord == selectedDatabase[i]) return true;
  }
  return false;
}