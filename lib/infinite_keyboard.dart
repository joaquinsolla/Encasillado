import 'package:flutter/material.dart';

import 'common_imagepaths.dart';
import 'common_pages.dart';
import 'common_variables.dart';
import 'common_widgets.dart';
import 'common_colors.dart';
import 'main_view.dart';


List<String> greenKeysInfinite = [];
List<String> yellowKeysInfinite = [];
List<String> greyKeysInfinite = [];

SizedBox my_letter_key(String char) {
  Color? mycolor = keyColor;

  for (var i = 0; i < greenKeysInfinite.length; i++) {
    if (char == greenKeysInfinite[i]) {
      mycolor = myGreen;
    }
  }
  if (mycolor == keyColor) {
    for (var i = 0; i < yellowKeysInfinite.length; i++) {
      if (char == yellowKeysInfinite[i]) {
        mycolor = myYellow;
      }
    }
  }
  if (mycolor == keyColor) {
    for (var i = 0; i < greyKeysInfinite.length; i++) {
      if (char == greyKeysInfinite[i]) {
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
          if (!finishedInfinite) {
            if (canWriteInfinite) {
              inputMatrixInfinite[currentCellInfinite] = char;
              currentCellInfinite++;
              if (currentCellInfinite == 5 ||
                  currentCellInfinite == 10 ||
                  currentCellInfinite == 15 ||
                  currentCellInfinite == 20 ||
                  currentCellInfinite == 25 ||
                  currentCellInfinite == 30) {
                canWriteInfinite = false;
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
        child: const Text(
          "PROBAR",
          style: TextStyle(fontSize: 12),
        ),
        style:
            TextButton.styleFrom(primary: myBlack, backgroundColor: keyColor),
        onPressed: () {
          if ((currentCellInfinite == 5 ||
                  currentCellInfinite == 10 ||
                  currentCellInfinite == 15 ||
                  currentCellInfinite == 20 ||
                  currentCellInfinite == 25 ||
                  currentCellInfinite == 30) &&
              canWriteInfinite == false) {
            if (infinite_word_exists()) {
              if (infinite_correct_word()) {
                if (!finishedInfinite) {
                  streak++;
                  finishedInfinite = true;
                  wonGameInfinite = true;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const infinite_finished_page()));
              } else {
                if (currentCellInfinite == 30) {
                  if (!finishedInfinite) {
                    streak = 0;
                    finishedInfinite = true;
                    wonGameInfinite = false;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const infinite_finished_page()));
                } else {
                  currentRowInfinite++;
                  canWriteInfinite = true;
                }
              }
            } else {
              word_doesnt_exist_snackbar(context);
            }
          }
          if (finishedInfinite) {
            endDateInfinite = DateTime.now();
            playSecondsInfinite = endDateInfinite.difference(startDateInfinite);
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
            if (!finishedInfinite) {
              if (currentCellInfinite == 0 ||
                  (currentCellInfinite == 5 && canWriteInfinite == true) ||
                  (currentCellInfinite == 10 && canWriteInfinite == true) ||
                  (currentCellInfinite == 15 && canWriteInfinite == true) ||
                  (currentCellInfinite == 20 && canWriteInfinite == true) ||
                  (currentCellInfinite == 25 && canWriteInfinite == true)) {
              } else {
                currentCellInfinite--;
                inputMatrixInfinite[currentCellInfinite] = "";
                canWriteInfinite = true;
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
            if (!finishedInfinite) {
              if (currentCellInfinite == 0 ||
                  (currentCellInfinite == 5 && canWriteInfinite == true) ||
                  (currentCellInfinite == 10 && canWriteInfinite == true) ||
                  (currentCellInfinite == 15 && canWriteInfinite == true) ||
                  (currentCellInfinite == 20 && canWriteInfinite == true) ||
                  (currentCellInfinite == 25 && canWriteInfinite == true)) {
              } else {
                currentCellInfinite--;
                inputMatrixInfinite[currentCellInfinite] = "";
                canWriteInfinite = true;
              }
              runApp(EncasilladoApp());
            }
          },
        ),
      ),
    );
  }
}

Column infinite_generate_keyboard(BuildContext context) {
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

bool infinite_correct_word() {
  String selectedWordString = infiniteString;
  List<String> selectedWordArray = infiniteArray;

  String inputWord = inputMatrixInfinite[currentRowInfinite * 5] +
      inputMatrixInfinite[currentRowInfinite * 5 + 1] +
      inputMatrixInfinite[currentRowInfinite * 5 + 2] +
      inputMatrixInfinite[currentRowInfinite * 5 + 3] +
      inputMatrixInfinite[currentRowInfinite * 5 + 4];

  List<String> correctLetterByLetter = ["", "", "", "", ""];
  for (var i = 0; i < 5; i++) {
    correctLetterByLetter[i] = selectedWordArray[i];
  }

  List<String> inputLetterByLetter = ["-", "-", "-", "-", "-"];
  for (var i = 0; i < 5; i++) {
    inputLetterByLetter[i] = inputMatrixInfinite[currentRowInfinite * 5 + i];
  }

  if (inputWord == selectedWordString) {
    colorsArrayInfinite[currentRowInfinite * 5 + 0] = "V";
    colorsArrayInfinite[currentRowInfinite * 5 + 1] = "V";
    colorsArrayInfinite[currentRowInfinite * 5 + 2] = "V";
    colorsArrayInfinite[currentRowInfinite * 5 + 3] = "V";
    colorsArrayInfinite[currentRowInfinite * 5 + 4] = "V";

    for (var i = 0; i < 5; i++) {
      greenKeysInfinite.insert(0, selectedWordArray[i]);
    }

    return true;
  } else {
    //GREEN
    for (var i = 0; i < 5; i++) {
      if (inputMatrixInfinite[currentRowInfinite * 5 + i] == selectedWordArray[i]) {
        colorsArrayInfinite[currentRowInfinite * 5 + i] = "V";
        greenKeysInfinite.insert(0, inputMatrixInfinite[currentRowInfinite * 5 + i]);
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
          colorsArrayInfinite[currentRowInfinite * 5 + i] = "A";
          yellowKeysInfinite.insert(0, inputLetterByLetter[i]);
          correctLetterByLetter[j] = "";
          inputLetterByLetter[i] = "-";
        }
      }
    }
    //GREY
    for (var i = 0; i < 5; i++) {
      if (inputLetterByLetter[i] != "-") {
        colorsArrayInfinite[currentRowInfinite * 5 + i] = "G";
        greyKeysInfinite.insert(0, inputLetterByLetter[i]);
      }
    }
    return false;
  }
}

bool infinite_word_exists() {
  String inputWord = inputMatrixInfinite[currentRowInfinite * 5] +
      inputMatrixInfinite[currentRowInfinite * 5 + 1] +
      inputMatrixInfinite[currentRowInfinite * 5 + 2] +
      inputMatrixInfinite[currentRowInfinite * 5 + 3] +
      inputMatrixInfinite[currentRowInfinite * 5 + 4];

  for (var i = 0; i < selectedDatabase.length; i++) {
    if (inputWord == selectedDatabase[i]) return true;
  }
  return false;
}