import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_version/new_version.dart';

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

  /** PERSISTENT DATA MANAGEMENT */
  _read_colorblind() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'colorblind';
    final value = prefs.getBool(key) ?? false;
    print('read: $value for colorblind');
    if (value == true){
      setState(() {
        colorBlind = value;
        appGreen = Colors.orange;
        appYellow = Colors.blue;
        greenEmoji = "🟧";
        yellowEmoji = "🟦";
      });
    } else {
      setState(() {
        colorBlind = value;
        appGreen = Colors.green;
        appYellow = Color(0xfff3d500);
        greenEmoji = "🟩";
        yellowEmoji = "🟨";
      });
    }
  }

  _read_darkmode() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'darkmode';
    final value = prefs.getBool(key) ?? false;
    print('read: $value for darkmode');
    if (value == true){
      setState(() {
        darkMode = true;
        appBlack = Colors.white;
        appWhite = Color(0xff2d2d2d);
        appSemiBlack = Colors.white;
        whiteEmoji = "⬛";
        keyColor = Color(0xff131313);
      });
    } else {
      setState(() {
        darkMode = false;
        appBlack = Colors.black;
        appWhite = Colors.white;
        appSemiBlack = Colors.black54;
        whiteEmoji = "⬜";
        keyColor = Color(0xffefefef);
      });
    }
  }

  _read_infinite_score() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'infinitescore';
    final value = prefs.getInt(key) ?? 0;
    print('read: $value for infinitescore');
      setState(() {
        infiniteScore = value;
      });
  }

  _save_infinite_score(int value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'infinitescore';
    prefs.setInt(key, value);
    print('saved $value on infinitescore');
  }

  _read_streak() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'streak';
    final value = prefs.getInt(key) ?? 0;
    print('read: $value for streak');
    setState(() {
      streak = value;
    });
  }

  _save_streak(int value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'streak';
    prefs.setInt(key, value);
    print('saved $value on streak');
  }

  _read_records() async {
    final prefs = await SharedPreferences.getInstance();

    final scoreRecordKey = 'scorerecord';
    final scoreRecordValue = prefs.getInt(scoreRecordKey) ?? 0;

    final streakRecordKey = 'streakrecord';
    final streakRecordValue = prefs.getInt(streakRecordKey) ?? 0;

    setState(() {
      scoreRecord = scoreRecordValue;
      streakRecord = streakRecordValue;
    });

    print('read: records');
  }

  _save_streak_record() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'streakrecord';
    prefs.setInt(key, streakRecord);
    print('saved $streakRecord on streakrecord');
  }

  _save_score_record() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'scorerecord';
    prefs.setInt(key, scoreRecord);
    print('saved $scoreRecord on scorerecord');
  }

  _read_stats() async {
    final prefs = await SharedPreferences.getInstance();

    final totalWotdGamesKey = 'totalwotdgames';
    final totalWotdGamesValue = prefs.getInt(totalWotdGamesKey) ?? 0;

    final winsAtFirstWotdKey = 'winsatfirstwotd';
    final winsAtFirstWotdValue = prefs.getInt(winsAtFirstWotdKey) ?? 0;

    final winsAtSecondWotdKey = 'winsatsecondwotd';
    final winsAtSecondWotdValue = prefs.getInt(winsAtSecondWotdKey) ?? 0;

    final winsAtThirdWotdKey = 'winsatthirdwotd';
    final winsAtThirdWotdValue = prefs.getInt(winsAtThirdWotdKey) ?? 0;

    final winsAtFourthWotdKey = 'winsatfourthwotd';
    final winsAtFourthWotdValue = prefs.getInt(winsAtFourthWotdKey) ?? 0;

    final winsAtFifthWotdKey = 'winsatfifthwotd';
    final winsAtFifthWotdValue = prefs.getInt(winsAtFifthWotdKey) ?? 0;

    final winsAtSixthWotdKey = 'winsatsixthwotd';
    final winsAtSixthWotdValue = prefs.getInt(winsAtSixthWotdKey) ?? 0;

    final defeatsAtWotdKey = 'defeatsatwotd';
    final defeatsAtWotdValue = prefs.getInt(defeatsAtWotdKey) ?? 0;
    //
    final totalInfiniteGamesKey = 'totalinfinitegames';
    final totalInfiniteGamesValue = prefs.getInt(totalInfiniteGamesKey) ?? 0;

    final winsAtFirstInfiniteKey = 'winsatfirstinfinite';
    final winsAtFirstInfiniteValue = prefs.getInt(winsAtFirstInfiniteKey) ?? 0;

    final winsAtSecondInfiniteKey = 'winsatsecondinfinite';
    final winsAtSecondInfiniteValue = prefs.getInt(winsAtSecondInfiniteKey) ?? 0;

    final winsAtThirdInfiniteKey = 'winsatthirdinfinite';
    final winsAtThirdInfiniteValue = prefs.getInt(winsAtThirdInfiniteKey) ?? 0;

    final winsAtFourthInfiniteKey = 'winsatfourthinfinite';
    final winsAtFourthInfiniteValue = prefs.getInt(winsAtFourthInfiniteKey) ?? 0;

    final winsAtFifthInfiniteKey = 'winsatfifthinfinite';
    final winsAtFifthInfiniteValue = prefs.getInt(winsAtFifthInfiniteKey) ?? 0;

    final winsAtSixthInfiniteKey = 'winsatsixthinfinite';
    final winsAtSixthInfiniteValue = prefs.getInt(winsAtSixthInfiniteKey) ?? 0;

    final defeatsAtInfiniteKey = 'defeatsatinfinite';
    final defeatsAtInfiniteValue = prefs.getInt(defeatsAtInfiniteKey) ?? 0;

    setState(() {
      totalWotdGames = totalWotdGamesValue;
      winsAtFirstWotd = winsAtFirstWotdValue;
      winsAtSecondWotd = winsAtSecondWotdValue;
      winsAtThirdWotd = winsAtThirdWotdValue;
      winsAtFourthWotd = winsAtFourthWotdValue;
      winsAtFifthWotd = winsAtFifthWotdValue;
      winsAtSixthWotd = winsAtSixthWotdValue;
      defeatsAtWotd = defeatsAtWotdValue;
      //
      totalInfiniteGames = totalInfiniteGamesValue;
      winsAtFirstInfinite = winsAtFirstInfiniteValue;
      winsAtSecondInfinite = winsAtSecondInfiniteValue;
      winsAtThirdInfinite = winsAtThirdInfiniteValue;
      winsAtFourthInfinite = winsAtFourthInfiniteValue;
      winsAtFifthInfinite = winsAtFifthInfiniteValue;
      winsAtSixthInfinite = winsAtSixthInfiniteValue;
      defeatsAtInfinite = defeatsAtInfiniteValue;
    });

    print('read: stats');
  }

  _save_wotd_stats(int variableSelector, int variableValue, int totalValue) async {
    final prefs = await SharedPreferences.getInstance();
    final key1;
    final key2 = 'totalwotdgames';
    if (variableSelector == 1){
      key1 = 'winsatfirstwotd';
    } else {
      if (variableSelector == 2){
        key1 = 'winsatsecondwotd';
      } else {
        if (variableSelector == 3){
          key1 = 'winsatthirdwotd';
        } else {
          if (variableSelector == 4){
            key1 = 'winsatfourthwotd';
          } else {
            if (variableSelector == 5){
              key1 = 'winsatfifthwotd';
            } else {
              if (variableSelector == 6){
                key1 = 'winsatsixthwotd';
              } else {
                key1 = 'defeatsatwotd';
              }
            }
          }
        }
      }
    }

    prefs.setInt(key1, variableValue);
    prefs.setInt(key2, totalValue);
  }

  _save_infinite_stats(int variableSelector, int variableValue, int totalValue) async {
    final prefs = await SharedPreferences.getInstance();
    final key1;
    final key2 = 'totalinfinitegames';
    if (variableSelector == 1){
      key1 = 'winsatfirstinfinite';
    } else {
      if (variableSelector == 2){
        key1 = 'winsatsecondinfinite';
      } else {
        if (variableSelector == 3){
          key1 = 'winsatthirdinfinite';
        } else {
          if (variableSelector == 4){
            key1 = 'winsatfourthinfinite';
          } else {
            if (variableSelector == 5){
              key1 = 'winsatfifthinfinite';
            } else {
              if (variableSelector == 6){
                key1 = 'winsatsixthinfinite';
              } else {
                key1 = 'defeatsatinfinite';
              }
            }
          }
        }
      }
    }

    prefs.setInt(key1, variableValue);
    prefs.setInt(key2, totalValue);
  }

  _read_trophies() async {
    final prefs = await SharedPreferences.getInstance();

    // INT
    final totalTrophiesKey = 'totaltrophies';
    final totalTrophiesValue = prefs.getInt(totalTrophiesKey) ?? 0;

    final diamondTrophiesKey = 'diamondtrophies';
    final diamondTrophiesValue = prefs.getInt(diamondTrophiesKey) ?? 0;

    final goldTrophiesKey = 'goldtrophies';
    final goldTrophiesValue = prefs.getInt(goldTrophiesKey) ?? 0;

    final silverTrophiesKey = 'silvertrophies';
    final silverTrophiesValue = prefs.getInt(silverTrophiesKey) ?? 0;

    final bronzeTrophiesKey = 'bronzetrophies';
    final bronzeTrophiesValue = prefs.getInt(bronzeTrophiesKey) ?? 0;

    // BOOL
    final allTrophiesTrKey = 'alltrophiestr';
    final allTrophiesTrValue = prefs.getBool(allTrophiesTrKey) ?? false;

    final streak25TrKey = 'streak25tr';
    final streak25TrValue = prefs.getBool(streak25TrKey) ?? false;

    final streak10TrKey = 'streak10tr';
    final streak10TrValue = prefs.getBool(streak10TrKey) ?? false;

    final streak5TrKey = 'streak5tr';
    final streak5TrValue = prefs.getBool(streak5TrKey) ?? false;

    final atFirstTrKey = 'atfirsttr';
    final atFirstTrValue = prefs.getBool(atFirstTrKey) ?? false;

    final atSecondTrKey = 'atsecondtr';
    final atSecondTrValue = prefs.getBool(atSecondTrKey) ?? false;

    final points5kTrKey = 'points5ktr';
    final points5kTrValue = prefs.getBool(points5kTrKey) ?? false;

    final points10kTrKey = 'points10ktr';
    final points10kTrValue = prefs.getBool(points10kTrKey) ?? false;

    final points25kTrKey = 'points25ktr';
    final points25kTrValue = prefs.getBool(points25kTrKey) ?? false;

    final firstPlayTrKey = 'firstplaytr';
    final firstPlayTrValue = prefs.getBool(firstPlayTrKey) ?? false;

    setState(() {
      totalTrophies = totalTrophiesValue;
      diamondTrophies = diamondTrophiesValue;
      goldTrophies = goldTrophiesValue;
      silverTrophies = silverTrophiesValue;
      bronzeTrophies = bronzeTrophiesValue;
      allTrophiesTr = allTrophiesTrValue;
      streak25Tr = streak25TrValue;
      streak10Tr = streak10TrValue;
      streak5Tr = streak5TrValue;
      atFirstTr = atFirstTrValue;
      atSecondTr = atSecondTrValue;
      points5kTr = points5kTrValue;
      points10kTr = points10kTrValue;
      points25kTr = points25kTrValue;
      firstPlayTr = firstPlayTrValue;
    });

    print('read: trophies');
  }

  _save_trophy(String trophyKey, String trophyType) async {
    final prefs = await SharedPreferences.getInstance();

    final key1 = trophyKey; // trophy
    final key2; // trophy type
    final key3 = 'totaltrophies'; // total trophies

    if (trophyType == 'gold'){
      key2 = 'goldtrophies';
      prefs.setInt(key2, goldTrophies);

    } else {
      if (trophyType == 'silver'){
        key2 = 'silvertrophies';
        prefs.setInt(key2, silverTrophies);

      } else {
        if (trophyType == 'bronze'){
          key2 = 'bronzetrophies';
          prefs.setInt(key2, bronzeTrophies);

        }
      }
    }

    prefs.setBool(key1, true);
    prefs.setInt(key3, totalTrophies);

    if (totalTrophies >= 9){
      setState(() {
        allTrophiesTr = true;
        diamondTrophies = 1;
      });
      final key4 = 'alltrophiestr'; // trophy
      final key5 = 'diamondtrophies'; // trophy type

      prefs.setBool(key4, true);
      prefs.setInt(key5, 1);

      //TODO: FLUSHBAR
    }
  }

  // ADMOB MANAGEMENT
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  // VERSION MANAGEMENT
  statusCheck(NewVersion newVersion) async {
    newVersion.showAlertIfNecessary(context: context);
  }

  @override
  void initState() {

    // VERSION MANAGEMENT
    final newVersion = NewVersion(
      iOSId: '',
      androidId: 'com.joa.encasillado',
    );

    if (appStarted ==  false) statusCheck(newVersion);

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    check_device();

    if (appStarted == false) {
      _read_colorblind();
      _read_darkmode();
      _read_infinite_score();
      _read_streak();
      _read_records();
      _read_stats();
      _read_trophies();

      check_settings();

      setState(() {
        appStarted = true;
      });
    }

    Color wotdButtonColor = appThirdColor;
    Color infiniteButtonColor = appMainColor;
    TextDecoration wotdDecoration = TextDecoration.underline;
    TextDecoration infiniteDecoration = TextDecoration.none;
    if (currentPage == 0){
      wotdButtonColor = appThirdColor;
      infiniteButtonColor = appMainColor;
      wotdDecoration = TextDecoration.underline;
      infiniteDecoration = TextDecoration.none;
    } else {
      wotdButtonColor = appMainColor;
      infiniteButtonColor = appThirdColor;
      wotdDecoration = TextDecoration.none;
      infiniteDecoration = TextDecoration.underline;
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
                        decoration: wotdDecoration,
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
                        decoration: infiniteDecoration,
                      ),
                    )),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
        if (currentPage == 0) gameBannerTwoButtons(context, '¡La palabra del día!', twitterBotButton(context), releaseNotesButton(context)),
        if (currentPage == 1) gameBannerOneButton(context, 'Palabras infinitas', scoreButton(context)),
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
            if (finishedWotd == false) {
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
            if (finishedInfinite == false) {
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
                  if (finishedWotd == false) {

                    setState(() {
                      finishedWotd = true;
                      wonGameWotd = true;
                      totalWotdGames++;
                    });

                    if ((currentRowWotd+1) == 1) {
                      setState(() {
                        winsAtFirstWotd++;
                      });
                      _save_wotd_stats(1, winsAtFirstWotd, totalWotdGames);
                      // trophy
                    }
                    if ((currentRowWotd+1) == 2) {
                      setState(() {
                        winsAtSecondWotd++;
                      });
                      _save_wotd_stats(2, winsAtSecondWotd, totalWotdGames);
                      // trophy
                    }
                    if ((currentRowWotd+1) == 3) {
                      setState(() {
                        winsAtThirdWotd++;
                      });
                      _save_wotd_stats(3, winsAtThirdWotd, totalWotdGames);
                    }
                    if ((currentRowWotd+1) == 4) {
                      setState(() {
                        winsAtFourthWotd++;
                      });
                      _save_wotd_stats(4, winsAtFourthWotd, totalWotdGames);
                    }
                    if ((currentRowWotd+1) == 5) {
                      setState(() {
                        winsAtFifthWotd++;
                      });
                      _save_wotd_stats(5, winsAtFifthWotd, totalWotdGames);
                    }
                    if ((currentRowWotd+1) == 6) {
                      setState(() {
                        winsAtSixthWotd++;
                      });
                      _save_wotd_stats(6, winsAtSixthWotd, totalWotdGames);
                    }

                  }
                  /** TROPHY FIRST PLAY */
                  if (firstPlayTr == false){
                    setState(() {
                      totalTrophies++;
                      bronzeTrophies++;
                      firstPlayTr = true;
                    });
                    _save_trophy('firstplaytr', 'silver');
                    //TODO: FLUSHBAR
                  }

                  Navigator.pushNamed(context, '/wotd_end');
                } else {
                  if (currentCellWotd == 30) {
                    if (finishedWotd == false) {

                      setState(() {
                        finishedWotd = true;
                        wonGameWotd = false;
                        finishedWotd = true;
                        totalWotdGames++;
                        defeatsAtWotd++;
                      });

                      _save_wotd_stats(0, defeatsAtWotd, totalWotdGames);

                    }
                    /** TROPHY FIRST PLAY */
                    if (firstPlayTr == false){
                      setState(() {
                        totalTrophies++;
                        bronzeTrophies++;
                        firstPlayTr = true;
                      });
                      _save_trophy('firstplaytr', 'silver');
                      //TODO: FLUSHBAR
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
                  if (finishedInfinite == false) {

                    setState(() {
                      finishedInfinite = true;
                      wonGameInfinite = true;
                      endDateInfinite = DateTime.now();
                      playSecondsInfinite = endDateInfinite.difference(startDateInfinite);
                      totalInfiniteGames++;
                    });

                    if ((currentRowInfinite+1) == 1) {
                      setState(() {
                        winsAtFirstInfinite++;
                      });
                      _save_infinite_stats(1, winsAtFirstInfinite, totalInfiniteGames);
                      /** TROPHY: A LA PRIMERA */
                      if (atFirstTr == false){
                        setState(() {
                          totalTrophies++;
                          goldTrophies++;
                          atFirstTr = true;
                        });
                        _save_trophy('atfirsttr', 'gold');
                        //TODO: FLUSHBAR
                      }
                    }
                    if ((currentRowInfinite+1) == 2) {
                      setState(() {
                        winsAtSecondInfinite++;
                      });
                      _save_infinite_stats(2, winsAtSecondInfinite, totalInfiniteGames);
                      /** TROPHY: A LA SEGUNDA */
                      if (atSecondTr == false){
                        setState(() {
                          totalTrophies++;
                          silverTrophies++;
                          atSecondTr = true;
                        });
                        _save_trophy('atsecondtr', 'silver');
                        //TODO: FLUSHBAR
                      }
                    }
                    if ((currentRowInfinite+1) == 3) {
                      setState(() {
                        winsAtThirdInfinite++;
                      });
                      _save_infinite_stats(3, winsAtThirdInfinite, totalInfiniteGames);
                    }
                    if ((currentRowInfinite+1) == 4) {
                      setState(() {
                        winsAtFourthInfinite++;
                      });
                      _save_infinite_stats(4, winsAtFourthInfinite, totalInfiniteGames);
                    }
                    if ((currentRowInfinite+1) == 5) {
                      setState(() {
                        winsAtFifthInfinite++;
                      });
                      _save_infinite_stats(5, winsAtFifthInfinite, totalInfiniteGames);
                    }
                    if ((currentRowInfinite+1) == 6) {
                      setState(() {
                        winsAtSixthInfinite++;
                      });
                      _save_infinite_stats(6, winsAtSixthInfinite, totalInfiniteGames);
                    }

                    infinite_update_score();
                  }
                  /** TROPHY FIRST PLAY */
                  if (firstPlayTr == false){
                    setState(() {
                      totalTrophies++;
                      bronzeTrophies++;
                      firstPlayTr = true;
                    });
                    _save_trophy('firstplaytr', 'silver');
                    //TODO: FLUSHBAR
                  }

                  Navigator.pushNamed(context, '/infinite_words_end');
                } else {
                  if (currentCellInfinite == 30) {
                    if (finishedInfinite == false) {

                      setState(() {
                        finishedInfinite = true;
                        wonGameInfinite = false;
                        endDateInfinite = DateTime.now();
                        playSecondsInfinite = endDateInfinite.difference(startDateInfinite);
                        totalInfiniteGames++;
                        defeatsAtInfinite++;
                      });

                      _save_infinite_stats(0, defeatsAtInfinite, totalInfiniteGames);
                      infinite_update_score();
                    }
                    /** TROPHY FIRST PLAY */
                    if (firstPlayTr == false){
                      setState(() {
                        totalTrophies++;
                        bronzeTrophies++;
                        firstPlayTr = true;
                      });
                      _save_trophy('firstplaytr', 'silver');
                      //TODO: FLUSHBAR
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
              if (finishedWotd == false) {
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
              if (finishedWotd == false) {
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
              if (finishedInfinite == false) {
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
              if (finishedInfinite == false) {
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
      deviceHeight = MediaQuery.of(context).size.height - 168.5 - 60 - 15; // 161.5 static px + 60 Ad + 15 Ad Margin
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

  void infinite_update_score(){

      int seconds = playSecondsInfinite.inSeconds;

      setState(() {
        if (wonGameInfinite) {
          if (seconds < 300) {
            if (currentRowInfinite == 0){
              infiniteScore += 10000;
            } else {
              infiniteScore += ((300 - seconds) *
                  (6 - currentRowInfinite) *
                  ((streak + 1) * 0.1 + 1))
                  .toInt() + 100;
            }
            if (infiniteScore > 9999999) infiniteScore = 9999999;
          } else infiniteScore += 100;

          streak++;
        } else {
          infiniteScore -= 300;
          streak=0;
        }
      });
      _save_infinite_score(infiniteScore);
      _save_streak(streak);
      if (infiniteScore > scoreRecord) {
        scoreRecord = infiniteScore;
        _save_score_record();
      }
      if (streak > streakRecord){
        streakRecord = streak;
        _save_streak_record();
      }

      /** SCORE RECORDS */
      if (points5kTr == false && infiniteScore >= 5000){
        setState(() {
          totalTrophies++;
          bronzeTrophies++;
          points5kTr = true;
        });
        _save_trophy('points5ktr', 'bronze');
        //TODO: FLUSHBAR
      }
      if (points10kTr == false && infiniteScore >= 10000){
        setState(() {
          totalTrophies++;
          silverTrophies++;
          points10kTr = true;
        });
        _save_trophy('points10ktr', 'silver');
        //TODO: FLUSHBAR
      }
      if (points25kTr == false && infiniteScore >= 25000){
        setState(() {
          totalTrophies++;
          goldTrophies++;
          points25kTr = true;
        });
        _save_trophy('points25ktr', 'gold');
        //TODO: FLUSHBAR
      }

      /** STREAK RECORDS */
      if (streak5Tr == false && streak >= 5){
        setState(() {
          totalTrophies++;
          bronzeTrophies++;
          streak5Tr = true;
        });
        _save_trophy('streak5tr', 'bronze');
        //TODO: FLUSHBAR
      }
      if (streak10Tr == false && streak >= 10){
        setState(() {
          totalTrophies++;
          silverTrophies++;
          streak10Tr = true;
        });
        _save_trophy('streak10tr', 'silver');
        //TODO: FLUSHBAR
      }
      if (streak25Tr == false && streak >= 25){
        setState(() {
          totalTrophies++;
          goldTrophies++;
          streak25Tr = true;
        });
        _save_trophy('streak25tr', 'gold');
        //TODO: FLUSHBAR
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
    timeStartedInfinite = false;
    timeStartedWotd = false;

    greenKeysInfinite = [];
    yellowKeysInfinite = [];
    greyKeysInfinite = [];

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