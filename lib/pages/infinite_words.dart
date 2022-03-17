import 'package:Encasillado/common/imagepaths.dart';
import 'package:flutter/material.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class InfiniteWords extends StatefulWidget {
  @override
  _InfiniteWordsState createState() => _InfiniteWordsState();
}

class _InfiniteWordsState extends State<InfiniteWords> {
  @override
  Widget build(BuildContext context) {

    setState(() {
      currentPage = 1;
    });

    return Scaffold(
      appBar: myAppBarWithButtonsAndWithoutBackArrow(context),
      backgroundColor: appWhite,
      body: Column(children: [
        Container(
          height: deviceHeight * 0.072,
          color: appSecondColor,
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/wotd');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: appMainColor,
                    ),
                    child: Text(
                      "¡La palabra del día!",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    )),
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: appThirdColor,
                    ),
                    child: Text(
                      "Palabras infinitas",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    )),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
        gameBanner(context, 'Palabras infinitas', scoreButton(context), streakButton(context)),
        cellsFieldInfinite(),
        Expanded(
          child: Text(""),
        ),
        infinite_generate_keyboard(context),
        SizedBox(
          height: 2.5,
        ),
      ]),
    );
  }

  // KEYBOARD MANAGEMENT

  List<String> greenKeysInfinite = [];
  List<String> yellowKeysInfinite = [];
  List<String> greyKeysInfinite = [];

  SizedBox my_letter_key(String char) {
    Color? mycolor = keyColor;

    for (var i = 0; i < greenKeysInfinite.length; i++) {
      if (char == greenKeysInfinite[i]) {
        mycolor = appGreen;
      }
    }
    if (mycolor == keyColor) {
      for (var i = 0; i < yellowKeysInfinite.length; i++) {
        if (char == yellowKeysInfinite[i]) {
          mycolor = appYellow;
        }
      }
    }
    if (mycolor == keyColor) {
      for (var i = 0; i < greyKeysInfinite.length; i++) {
        if (char == greyKeysInfinite[i]) {
          mycolor = appGrey;
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
            primary: appBlack,
            backgroundColor: mycolor,
          ),
          onPressed: () {
            if(timeStartedInfinite == false) {
              setState(() {
                startDateInfinite = DateTime.now();
                timeStartedInfinite = true;
              });
            }
            if (!finishedInfinite) {
              if (canWriteInfinite) {
                setState(() {
                  inputMatrixInfinite[currentCellInfinite] = char;
                  currentCellInfinite++;
                });
                if (currentCellInfinite == 5 ||
                    currentCellInfinite == 10 ||
                    currentCellInfinite == 15 ||
                    currentCellInfinite == 20 ||
                    currentCellInfinite == 25 ||
                    currentCellInfinite == 30) {
                  setState(() {
                    canWriteInfinite = false;
                  });
                }
              }
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
          TextButton.styleFrom(primary: appBlack, backgroundColor: keyColor),
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
                    setState(() {
                      streak++;
                      finishedInfinite = true;
                      wonGameInfinite = true;
                    });
                  }
                  Navigator.pushNamed(context, '/infinite_words_end');
                } else {
                  if (currentCellInfinite == 30) {
                    if (!finishedInfinite) {
                      setState(() {
                        streak = 0;
                        finishedInfinite = true;
                        wonGameInfinite = false;
                      });
                    }
                    Navigator.pushNamed(context, '/infinite_words_end');
                  } else {
                    setState(() {
                      currentRowInfinite++;
                      canWriteInfinite = true;
                    });
                  }
                }
              } else {
                word_doesnt_exist_snackbar(context);
              }
            }
            if (finishedInfinite && alreadyTimeMeasuredInfinite == false) {
              setState(() {
                endDateInfinite = DateTime.now();
                playSecondsInfinite = endDateInfinite.difference(startDateInfinite);
                alreadyTimeMeasuredInfinite = true;
              });
            }
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
            child: Image.asset(backspaceImgDarkmode),
            onPressed: () {
              if (!finishedInfinite) {
                if (currentCellInfinite == 0 ||
                    (currentCellInfinite == 5 && canWriteInfinite == true) ||
                    (currentCellInfinite == 10 && canWriteInfinite == true) ||
                    (currentCellInfinite == 15 && canWriteInfinite == true) ||
                    (currentCellInfinite == 20 && canWriteInfinite == true) ||
                    (currentCellInfinite == 25 && canWriteInfinite == true)) {
                } else {
                  setState(() {
                    currentCellInfinite--;
                    inputMatrixInfinite[currentCellInfinite] = "";
                    canWriteInfinite = true;
                  });
                }
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
            child: Image.asset(backspaceImgLightmode),
            onPressed: () {
              if (!finishedInfinite) {
                if (currentCellInfinite == 0 ||
                    (currentCellInfinite == 5 && canWriteInfinite == true) ||
                    (currentCellInfinite == 10 && canWriteInfinite == true) ||
                    (currentCellInfinite == 15 && canWriteInfinite == true) ||
                    (currentCellInfinite == 20 && canWriteInfinite == true) ||
                    (currentCellInfinite == 25 && canWriteInfinite == true)) {
                } else {
                  setState(() {
                    currentCellInfinite--;
                    inputMatrixInfinite[currentCellInfinite] = "";
                    canWriteInfinite = true;
                  });
                }
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
      setState(() {
        colorsArrayInfinite[currentRowInfinite * 5 + 0] = "V";
        colorsArrayInfinite[currentRowInfinite * 5 + 1] = "V";
        colorsArrayInfinite[currentRowInfinite * 5 + 2] = "V";
        colorsArrayInfinite[currentRowInfinite * 5 + 3] = "V";
        colorsArrayInfinite[currentRowInfinite * 5 + 4] = "V";
      });

      for (var i = 0; i < 5; i++) {
        setState(() {
          greenKeysInfinite.insert(0, selectedWordArray[i]);
        });
      }

      return true;
    } else {
      //GREEN
      for (var i = 0; i < 5; i++) {
        if (inputMatrixInfinite[currentRowInfinite * 5 + i] ==
            selectedWordArray[i]) {
          setState(() {
            colorsArrayInfinite[currentRowInfinite * 5 + i] = "V";
            greenKeysInfinite.insert(
                0, inputMatrixInfinite[currentRowInfinite * 5 + i]);
            correctLetterByLetter[i] = "";
            inputLetterByLetter[i] = "-";
          });
        }
      }
      //YELLOW
      for (var i = 0; i < 5; i++) {
        for (var j = 0; j < 5; j++) {
          if (inputLetterByLetter[i] == correctLetterByLetter[j] &&
              inputLetterByLetter[i] != "-" &&
              correctLetterByLetter[j] != "") {
            setState(() {
              colorsArrayInfinite[currentRowInfinite * 5 + i] = "A";
              yellowKeysInfinite.insert(0, inputLetterByLetter[i]);
              correctLetterByLetter[j] = "";
              inputLetterByLetter[i] = "-";
            });
          }
        }
      }
      //GREY
      for (var i = 0; i < 5; i++) {
        if (inputLetterByLetter[i] != "-") {
          setState(() {
            colorsArrayInfinite[currentRowInfinite * 5 + i] = "G";
            greyKeysInfinite.insert(0, inputLetterByLetter[i]);
          });
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


}