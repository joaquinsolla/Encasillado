import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/ad_helper.dart';
import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/common/urls.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // ADMOB MANAGEMENT
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {

    if (showAds) {
      _initGoogleMobileAds();
      _bannerAd = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              _isBannerAdReady = true;
            });
          },
          onAdFailedToLoad: (ad, err) {
            print('Failed to load a banner ad: ${err.message}');
            _isBannerAdReady = false;
            ad.dispose();
          },
        ),
      );

      _bannerAd.load();
    }
  }

  @override
  Widget build(BuildContext context) {

    check_device();

    if (appStarted == false) {
      var brightness = MediaQuery.of(context).platformBrightness;
      setState(() {
        darkMode = brightness == Brightness.dark;
      });

      check_settings();

      setState(() {
        appStarted = true;
      });
    }

    Color wotdButtonColor = appThirdColor;
    Color infiniteButtonColor = appMainColor;
    if (currentPage == 0){
      wotdButtonColor = appThirdColor;
      infiniteButtonColor = appMainColor;
    } else {
      wotdButtonColor = appMainColor;
      infiniteButtonColor = appThirdColor;
    }

    if (newInfiniteGame) {
      infinite_reset_variables();
      infinite_generate_word();
    }

    return Scaffold(
      appBar: myAppBarWithButtonsWithoutBackArrow(context),
      backgroundColor: appWhite,
      body: Column(children: [
        Container(
          height: 54,
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
                      if (currentPage == 1){
                       setState(() {
                         currentPage = 0;
                       });
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: wotdButtonColor,
                    ),
                    child: Text(
                      "¡La palabra del día!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    )),
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      if (currentPage == 0){
                        setState(() {
                          currentPage = 1;
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: infiniteButtonColor,
                    ),
                    child: Text(
                      "Palabras infinitas",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
        if (currentPage == 0) gameBanner(context, '¡La palabra del día!', twitterBotButton(context), currentVersionButton(context)),
        if (currentPage == 1) gameBanner(context, 'Palabras infinitas', scoreButton(context), streakButton(context)),
        if (currentPage == 0) wotdLettersField(),
        if (currentPage == 1) infiniteLettersField(),
        Expanded(child: Text(""),),
        if (_isBannerAdReady) smallText('ADVERTISING'),
        if (_isBannerAdReady) Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: _bannerAd.size.width.toDouble(),
            height: _bannerAd.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd),
          ),
        ),
        SizedBox(height: 15,),
        if (currentPage == 0) wotdKeyboard(context),
        if (currentPage == 1) infiniteKeyboard(context),
        SizedBox(
          height: 2.5,
        ),
      ]),
    );
  }

  // KEYBOARD GENERATION

  List<String> greenKeysWotd = [];
  List<String> yellowKeysWotd = [];
  List<String> greyKeysWotd = [];

  List<String> greenKeysInfinite = [];
  List<String> yellowKeysInfinite = [];
  List<String> greyKeysInfinite = [];

  SizedBox wotdLetterKey(String char) {
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

  SizedBox infiniteLetterKey(String char) {
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

  SizedBox wotdEnterKey(BuildContext context) {
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
                if (wotd_check_word()) {
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
                wordDoesNotExistFlushbar(context);
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

  SizedBox infiniteEnterKey(BuildContext context) {
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
                if (infinite_check_word()) {
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
                wordDoesNotExistFlushbar(context);
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

  SizedBox wotdBackspaceKey() {
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

  SizedBox infiniteBackspaceKey() {
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

  Column wotdKeyboard(BuildContext context) {
    return Column(
      children: [
        //ROW 1
        Row(
          children: [
            wotdLetterKey("Q"),
            wotdLetterKey("W"),
            wotdLetterKey("E"),
            wotdLetterKey("R"),
            wotdLetterKey("T"),
            wotdLetterKey("Y"),
            wotdLetterKey("U"),
            wotdLetterKey("I"),
            wotdLetterKey("O"),
            wotdLetterKey("P"),
          ],
        ),

        //ROW 2
        Row(
          children: [
            wotdLetterKey("A"),
            wotdLetterKey("S"),
            wotdLetterKey("D"),
            wotdLetterKey("F"),
            wotdLetterKey("G"),
            wotdLetterKey("H"),
            wotdLetterKey("J"),
            wotdLetterKey("K"),
            wotdLetterKey("L"),
            wotdLetterKey("Ñ"),
          ],
        ),

        //ROW 3
        Row(
          children: [
            wotdEnterKey(context),
            wotdLetterKey("Z"),
            wotdLetterKey("X"),
            wotdLetterKey("C"),
            wotdLetterKey("V"),
            wotdLetterKey("B"),
            wotdLetterKey("N"),
            wotdLetterKey("M"),
            wotdBackspaceKey(),
          ],
        ),
      ],
    );
  }

  Column infiniteKeyboard(BuildContext context) {
    return Column(
      children: [
        //ROW 1
        Row(
          children: [
            infiniteLetterKey("Q"),
            infiniteLetterKey("W"),
            infiniteLetterKey("E"),
            infiniteLetterKey("R"),
            infiniteLetterKey("T"),
            infiniteLetterKey("Y"),
            infiniteLetterKey("U"),
            infiniteLetterKey("I"),
            infiniteLetterKey("O"),
            infiniteLetterKey("P"),
          ],
        ),

        //ROW 2
        Row(
          children: [
            infiniteLetterKey("A"),
            infiniteLetterKey("S"),
            infiniteLetterKey("D"),
            infiniteLetterKey("F"),
            infiniteLetterKey("G"),
            infiniteLetterKey("H"),
            infiniteLetterKey("J"),
            infiniteLetterKey("K"),
            infiniteLetterKey("L"),
            infiniteLetterKey("Ñ"),
          ],
        ),

        //ROW 3
        Row(
          children: [
            infiniteEnterKey(context),
            infiniteLetterKey("Z"),
            infiniteLetterKey("X"),
            infiniteLetterKey("C"),
            infiniteLetterKey("V"),
            infiniteLetterKey("B"),
            infiniteLetterKey("N"),
            infiniteLetterKey("M"),
            infiniteBackspaceKey(),
          ],
        ),
      ],
    );
  }

  // WORD CONTROL

  bool wotd_check_word() {
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

  bool infinite_check_word() {
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

  // LETTERS FIELD MANAGEMENT

  AnimatedContainer letterCell(String char, String col) {
    //COLOR SELECTION
    Color? cellColor = appWhite;
    if (col == "V") cellColor = appGreen;
    if (col == "A") cellColor = appYellow;
    if (col == "G") cellColor = appGrey;

    return AnimatedContainer(
      duration: Duration(milliseconds: 750),
      curve: Curves.easeInOutCirc,
      width: ((deviceHeight * 0.53) / 6) -8,
      height: ((deviceHeight * 0.53) / 6) -8,
      margin: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 6.0),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: cellColor,
        border: Border.all(color: appSemiBlack, width: 0.0),
      ),
      child: Text(
        char,
        style:
        TextStyle(fontSize: ((deviceHeight * 0.52) / 6 - 28), color: appBlack),
      ),
    );
  }

  Row wotdLetterRow(int _from) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        letterCell(inputMatrixWotd[_from], colorsArrayWotd[_from]),
        letterCell(inputMatrixWotd[_from + 1], colorsArrayWotd[_from + 1]),
        letterCell(inputMatrixWotd[_from + 2], colorsArrayWotd[_from + 2]),
        letterCell(inputMatrixWotd[_from + 3], colorsArrayWotd[_from + 3]),
        letterCell(inputMatrixWotd[_from + 4], colorsArrayWotd[_from + 4]),
      ],
    );
  }

  Row infiniteLetterRow(int _from) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        letterCell(inputMatrixInfinite[_from], colorsArrayInfinite[_from]),
        letterCell(
            inputMatrixInfinite[_from + 1], colorsArrayInfinite[_from + 1]),
        letterCell(
            inputMatrixInfinite[_from + 2], colorsArrayInfinite[_from + 2]),
        letterCell(
            inputMatrixInfinite[_from + 3], colorsArrayInfinite[_from + 3]),
        letterCell(
            inputMatrixInfinite[_from + 4], colorsArrayInfinite[_from + 4]),
      ],
    );
  }

  Column wotdLettersField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.0,
          ),
          wotdLetterRow(0),
          wotdLetterRow(5),
          wotdLetterRow(10),
          wotdLetterRow(15),
          wotdLetterRow(20),
          wotdLetterRow(25),
        ]);
  }

  Column infiniteLettersField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.0,
          ),
          infiniteLetterRow(0),
          infiniteLetterRow(5),
          infiniteLetterRow(10),
          infiniteLetterRow(15),
          infiniteLetterRow(20),
          infiniteLetterRow(25),
        ]);
  }

  // OTHERS

  void check_device() {
    setState(() {
      deviceWidth = MediaQuery.of(context).size.width;
      deviceHeight = MediaQuery.of(context).size.height - 168.5 - 60 - 10; // 161.5 static px + 60 Ad + 10 Ad Margin
      keyHeight = (deviceHeight) * 0.1;
    });
  }

  void check_settings() {
    if (colorBlind) {
      setState(() {
        appGreen = Colors.orange;
        appYellow = Colors.blue;
        greenEmoji = "🟧";
        yellowEmoji = "🟦";
      });
    } else {
      setState(() {
        appGreen = Colors.green;
        appYellow = Color(0xfff3d500);
        greenEmoji = "🟩";
        yellowEmoji = "🟨";
      });
    }

    if (darkMode) {
      setState(() {
        appBlack = Colors.white;
        appWhite = Color(0xff2d2d2d);
        appSemiBlack = Colors.white;
        whiteEmoji = "⬛";
        keyColor = Color(0xff131313);
      });
    } else {
      setState(() {
        appBlack = Colors.black;
        appWhite = Colors.white;
        appSemiBlack = Colors.black54;
        whiteEmoji = "⬜";
        keyColor = Color(0xffefefef);
      });
    }
  }

  void infinite_reset_variables() {
    setState(() {
    newInfiniteGame = false;

    currentCellInfinite = 0;
    currentRowInfinite = 0;
    canWriteInfinite = true;
    finishedInfinite = false;

    infiniteArray = ["", "", "", "", ""];
    infiniteString = "";
    infiniteDefinitionURL = "https://dle.rae.es/";

    wonGameInfinite = false;
    infoStatsInfinite = "";
    emojiStatsInfinite = "";
    startDateInfinite = DateTime.parse("2000-01-01 00:00:00.000000");
    endDateInfinite = DateTime.parse("2000-01-01 00:00:00.000000");
    playSecondsInfinite = endDateInfinite.difference(startDateInfinite);
    alreadyTimeMeasuredInfinite = false;
    alreadyPointsCalculatedInfinite = false;
    timeStartedInfinite = false;
    timeStartedWotd = false;

    inputMatrixInfinite = [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
    ];

    colorsArrayInfinite = [
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B",
      "B"
    ];
    });
  }

}