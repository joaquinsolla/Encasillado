import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/methods.dart';
import 'package:flutter/material.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class Wotd extends StatefulWidget {
  @override
  _WotdState createState() => _WotdState();
}

class _WotdState extends State<Wotd> {
  @override
  Widget build(BuildContext context) {
    if (appStarted == false) {
      var brightness = MediaQuery.of(context).platformBrightness;
      darkMode = brightness == Brightness.dark;
    }

    Color wotdButtonColor = appMainColor;
    Color infiniteButtonColor = appThirdColor;
    TextStyle wotdStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.wavy,
    );
    TextStyle infiniteStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
    );

    if (currentPage == 0) {
      wotdButtonColor = appThirdColor;
      infiniteButtonColor = appMainColor;
      wotdStyle = TextStyle(
        color: Colors.white,
        fontSize: 12,
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.wavy,
      );
      infiniteStyle = TextStyle(
        color: Colors.white,
        fontSize: 12,
      );
    }
    if (currentPage == 1) {
      wotdButtonColor = appMainColor;
      infiniteButtonColor = appThirdColor;
      wotdStyle = TextStyle(
        color: Colors.white,
        fontSize: 12,
      );
      infiniteStyle = TextStyle(
        color: Colors.white,
        fontSize: 12,
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.wavy,
      );
    }

    check_device(context);
    check_settings();

    setState(() {
      appStarted = true;
    });

    return Scaffold(
      appBar: myAppBarWithoutButtons(context),
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
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: wotdButtonColor,
                    ),
                    child: Text(
                      "¡La palabra del día!",
                      style: wotdStyle,
                    )),
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/infinite_words');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: infiniteButtonColor,
                    ),
                    child: Text(
                      "Palabras infinitas",
                      style: infiniteStyle,
                    )),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
        gameBanner(context, '¡La palabra del día!', twitterBotButton(context), currentVersionButton(context)),
        cellsFieldWotd(),
        Expanded(
          child: Text(""),
        ),
        wotd_generate_keyboard(context),
        SizedBox(
          height: 2.5,
        ),
      ]),
    );
  }

  // KEYBOARD MANAGEMENT

  List<String> greenKeysWotd = [];
  List<String> yellowKeysWotd = [];
  List<String> greyKeysWotd = [];

  SizedBox my_letter_key(String char) {
    Color? mycolor = keyColor;

    for (var i = 0; i < greenKeysWotd.length; i++) {
      if (char == greenKeysWotd[i]) {
        mycolor = appGreen;
      }
    }
    if (mycolor == keyColor) {
      for (var i = 0; i < yellowKeysWotd.length; i++) {
        if (char == yellowKeysWotd[i]) {
          mycolor = appYellow;
        }
      }
    }
    if (mycolor == keyColor) {
      for (var i = 0; i < greyKeysWotd.length; i++) {
        if (char == greyKeysWotd[i]) {
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
            if(timeStartedWotd == false) {
              setState(() {
                startDateWotd = DateTime.now();
                timeStartedWotd = true;
              });
            }
            if (!finishedWotd) {
              if (canWriteWotd) {
                setState(() {
                  inputMatrixWotd[currentCellWotd] = char;
                  currentCellWotd++;
                });
                if (currentCellWotd == 5 ||
                    currentCellWotd == 10 ||
                    currentCellWotd == 15 ||
                    currentCellWotd == 20 ||
                    currentCellWotd == 25 ||
                    currentCellWotd == 30) {
                  setState(() {
                    canWriteWotd = false;
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
            if ((currentCellWotd == 5 ||
                currentCellWotd == 10 ||
                currentCellWotd == 15 ||
                currentCellWotd == 20 ||
                currentCellWotd == 25 ||
                currentCellWotd == 30) &&
                canWriteWotd == false) {
              if (wotd_word_exists()) {
                if (wotd_correct_word()) {
                  if (!finishedWotd) {
                    setState(() {
                      finishedWotd = true;
                      wonGameWotd = true;
                      finishedWotd = true;
                    });
                  }
                  Navigator.pushNamed(context, '/wotd_end');
                } else {
                  if (currentCellWotd == 30) {
                    if (!finishedWotd) {
                      setState(() {
                        finishedWotd = true;
                        wonGameWotd = false;
                        finishedWotd = true;
                      });
                    }
                    Navigator.pushNamed(context, '/wotd_end');
                  } else {
                    setState(() {
                      currentRowWotd++;
                      canWriteWotd = true;
                    });
                  }
                }
              } else {
                word_doesnt_exist_snackbar(context);
              }
            }
            if (finishedWotd && alreadyTimeMeasuredWotd == false) {
              setState(() {
                endDateWotd = DateTime.now();
                playSecondsWotd = endDateWotd.difference(startDateWotd);
                alreadyTimeMeasuredWotd = true;
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
              if (!finishedWotd) {
                if (currentCellWotd == 0 ||
                    (currentCellWotd == 5 && canWriteWotd == true) ||
                    (currentCellWotd == 10 && canWriteWotd == true) ||
                    (currentCellWotd == 15 && canWriteWotd == true) ||
                    (currentCellWotd == 20 && canWriteWotd == true) ||
                    (currentCellWotd == 25 && canWriteWotd == true)) {
                } else {
                  setState(() {
                    currentCellWotd--;
                    inputMatrixWotd[currentCellWotd] = "";
                    canWriteWotd = true;
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
              if (!finishedWotd) {
                if (currentCellWotd == 0 ||
                    (currentCellWotd == 5 && canWriteWotd == true) ||
                    (currentCellWotd == 10 && canWriteWotd == true) ||
                    (currentCellWotd == 15 && canWriteWotd == true) ||
                    (currentCellWotd == 20 && canWriteWotd == true) ||
                    (currentCellWotd == 25 && canWriteWotd == true)) {
                } else {
                  setState(() {
                    currentCellWotd--;
                    inputMatrixWotd[currentCellWotd] = "";
                    canWriteWotd = true;
                  });
                }
              }
            },
          ),
        ),
      );
    }
  }

  Column wotd_generate_keyboard(BuildContext context) {
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

  bool wotd_correct_word() {
    String selectedWordString = wotdString;
    List<String> selectedWordArray = wotdArray;

    String inputWord = inputMatrixWotd[currentRowWotd * 5] +
        inputMatrixWotd[currentRowWotd * 5 + 1] +
        inputMatrixWotd[currentRowWotd * 5 + 2] +
        inputMatrixWotd[currentRowWotd * 5 + 3] +
        inputMatrixWotd[currentRowWotd * 5 + 4];

    List<String> correctLetterByLetter = ["", "", "", "", ""];
    for (var i = 0; i < 5; i++) {
      correctLetterByLetter[i] = selectedWordArray[i];
    }

    List<String> inputLetterByLetter = ["-", "-", "-", "-", "-"];
    for (var i = 0; i < 5; i++) {
      inputLetterByLetter[i] = inputMatrixWotd[currentRowWotd * 5 + i];
    }

    if (inputWord == selectedWordString) {
      setState(() {
        colorsArrayWotd[currentRowWotd * 5 + 0] = "V";
        colorsArrayWotd[currentRowWotd * 5 + 1] = "V";
        colorsArrayWotd[currentRowWotd * 5 + 2] = "V";
        colorsArrayWotd[currentRowWotd * 5 + 3] = "V";
        colorsArrayWotd[currentRowWotd * 5 + 4] = "V";
      });

      for (var i = 0; i < 5; i++) {
        setState(() {
          greenKeysWotd.insert(0, selectedWordArray[i]);
        });
      }

      return true;
    } else {
      //GREEN
      for (var i = 0; i < 5; i++) {
        if (inputMatrixWotd[currentRowWotd * 5 + i] == selectedWordArray[i]) {
          setState(() {
            colorsArrayWotd[currentRowWotd * 5 + i] = "V";
            greenKeysWotd.insert(0, inputMatrixWotd[currentRowWotd * 5 + i]);
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
              colorsArrayWotd[currentRowWotd * 5 + i] = "A";
              yellowKeysWotd.insert(0, inputLetterByLetter[i]);
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
            colorsArrayWotd[currentRowWotd * 5 + i] = "G";
            greyKeysWotd.insert(0, inputLetterByLetter[i]);
          });
        }
      }
      return false;
    }
  }

  bool wotd_word_exists() {
    String inputWord = inputMatrixWotd[currentRowWotd * 5] +
        inputMatrixWotd[currentRowWotd * 5 + 1] +
        inputMatrixWotd[currentRowWotd * 5 + 2] +
        inputMatrixWotd[currentRowWotd * 5 + 3] +
        inputMatrixWotd[currentRowWotd * 5 + 4];

    for (var i = 0; i < selectedDatabase.length; i++) {
      if (inputWord == selectedDatabase[i]) return true;
    }
    return false;
  }

}