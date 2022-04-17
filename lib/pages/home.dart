import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_version/new_version.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

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

  /** PERSISTENT DATA MANAGEMENT & TROPHIES*/
  _read_ever_played() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'everplayed';
    final value = prefs.getBool(key) ?? false;
    if(terminalPrinting) print('[SYS] Read: $value for everplayed');
    setState(() {
      everPlayed = value;
    });
  }

  _save_ever_played() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'everplayed';
    prefs.setBool(key, true);
    if(terminalPrinting) print('[SYS] Saved true on everplayed');
  }

  _read_colorblind() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'colorblind';
    final value = prefs.getBool(key) ?? false;
    if(terminalPrinting) print('[SYS] Read: $value for colorblind');
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
    if(terminalPrinting) print('[SYS] Read: $value for darkmode');
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
    if(terminalPrinting) print('[SYS] Read: $value for infinitescore');
      setState(() {
        infiniteScore = value;
      });
  }

  _save_infinite_score(int value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'infinitescore';
    prefs.setInt(key, value);
    if(terminalPrinting) print('[SYS] Saved $value on infinitescore');
  }

  _read_streak() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'streak';
    final value = prefs.getInt(key) ?? 0;
    if(terminalPrinting) print('[SYS] Read: $value for streak');
    setState(() {
      streak = value;
    });
  }

  _save_streak(int value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'streak';
    prefs.setInt(key, value);
    if(terminalPrinting) print('[SYS] Saved $value on streak');
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

    if(terminalPrinting) print('[SYS] Read: records');
  }

  _save_streak_record() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'streakrecord';
    prefs.setInt(key, streakRecord);
    if(terminalPrinting) print('[SYS] Saved $streakRecord on streakrecord');
  }

  _save_score_record() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'scorerecord';
    prefs.setInt(key, scoreRecord);
    if(terminalPrinting) print('[SYS] Saved $scoreRecord on scorerecord');
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

    if(terminalPrinting) print('[SYS] Read: stats');
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
    if(terminalPrinting) print('[SYS] Saved wotd_stats');
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

    if(terminalPrinting) print('[SYS] Saved: infinite_stats');
  }

  _read_trophies() async {
    final prefs = await SharedPreferences.getInstance();

    // INT
    final totalTrophiesKey = 'totaltrophies';
    final totalTrophiesValue = prefs.getInt(totalTrophiesKey) ?? 0;

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

    final days7wotdTrKey = 'days7wotdtr';
    final days7wotdTrValue = prefs.getBool(days7wotdTrKey) ?? false;

    final days15wotdTrKey = 'days15wotdtr';
    final days15wotdTrValue = prefs.getBool(days15wotdTrKey) ?? false;

    final days30wotdTrKey = 'days30wotdtr';
    final days30wotdTrValue = prefs.getBool(days30wotdTrKey) ?? false;

    final secretWordTrKey = 'secretwordtr';
    final secretWordTrValue = prefs.getBool(secretWordTrKey) ?? false;

    setState(() {
      totalTrophies = totalTrophiesValue;
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
      days7wotdTr = days7wotdTrValue;
      days15wotdTr = days15wotdTrValue;
      days30wotdTr = days30wotdTrValue;
      secretWordTr = secretWordTrValue;
    });

    if(terminalPrinting) print('[SYS] Read: trophies');
  }

  _save_trophy(String trophyKey, String trophyType) async {
    final prefs = await SharedPreferences.getInstance();

    final key1 = trophyKey; // trophy
    final key2; // trophy type
    final key3 = 'totaltrophies'; // total trophies

    String msg = '';

    if (trophyType == 'gold'){
      key2 = 'goldtrophies';
      prefs.setInt(key2, goldTrophies);
      msg = '¡Trofeo de oro conseguido!';
    } else {
      if (trophyType == 'silver'){
        key2 = 'silvertrophies';
        prefs.setInt(key2, silverTrophies);
        msg = '¡Trofeo de plata conseguido!';
      } else {
        if (trophyType == 'bronze'){
          key2 = 'bronzetrophies';
          prefs.setInt(key2, bronzeTrophies);
          msg = '¡Trofeo de bronce conseguido!';
        }
      }
    }

    prefs.setBool(key1, true);
    prefs.setInt(key3, totalTrophies);

    if (totalTrophies >= 12){
      setState(() {
        allTrophiesTr = true;
        diamondTrophies = 1;
      });

      rewardFlushbar(context);

    } else trophyFlushbar(context, msg);

    if(terminalPrinting) print('[SYS] Saved: trophy');
  }

  _read_last_day_wotd() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'lastdaywotd';
    final value = prefs.getString(key) ?? '2000-01-01';
    if(terminalPrinting) print('[SYS] Read: $value for lastdaywotd');
    setState(() {
      lastDayWotd = value;
    });

    check_wotd_done();
  }

  _save_last_day_wotd(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'lastdaywotd';
    prefs.setString(key, value);
    if(terminalPrinting) print('[SYS] Saved $value on lastdaywotd');
  }

  _read_consecutive_days_wotd() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'consecutivedayswotd';
    final value = prefs.getInt(key) ?? 0;
    if(terminalPrinting) print('[SYS] Read: $value for consecutivedayswotd');
    setState(() {
      consecutiveDaysWotd = value;
    });
  }

  _save_consecutive_days_wotd(int value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'consecutivedayswotd';
    prefs.setInt(key, value);
    if(terminalPrinting) print('[SYS] Saved $value on consecutivedayswotd');
  }

  void check_wotd_days() {

    final format = DateFormat('yyyy-MM-dd');
    final now = format.format(DateTime.now());

    DateTime today = DateTime.parse(now);
    DateTime lastDay = DateTime.parse(lastDayWotd);

    var yesterday = new DateTime(today.year, today.month, today.day - 1);

    if(yesterday.compareTo(lastDay) == 0){
      if(terminalPrinting) print('[SYS] Last wotd game was yesterday');
      setState(() {
        consecutiveDaysWotd++;
      });

    } else {
      if(terminalPrinting) print("[SYS] Last wotd game wasn't yesterday");
      if(today.compareTo(lastDay) == 0){}
      else {
        setState(() {
          consecutiveDaysWotd=1;
        });
      }

    }

    setState(() {
      lastDayWotd = DateFormat('yyyy-MM-dd').format(today);
    });

    _save_last_day_wotd(lastDayWotd);
    _save_consecutive_days_wotd(consecutiveDaysWotd);

    /** CHECK TROPHIES */
    if (days7wotdTr == false && consecutiveDaysWotd == 7) {
      setState(() {
        days7wotdTr = true;
        bronzeTrophies++;
        totalTrophies++;
        _save_trophy('days7wotdtr', 'bronze');
      });
    }
    if (days15wotdTr == false && consecutiveDaysWotd == 15) {
      setState(() {
        days15wotdTr = true;
        silverTrophies++;
        totalTrophies++;
        _save_trophy('days15wotdtr', 'silver');
      });
    }
    if (days30wotdTr == false && consecutiveDaysWotd == 30) {
      setState(() {
        days30wotdTr = true;
        goldTrophies++;
        totalTrophies++;
        _save_trophy('days30wotdtr', 'gold');
      });
    }

  }

  void check_wotd_done() {

    final format = DateFormat('yyyy-MM-dd');
    final now = format.format(DateTime.now());

    DateTime today = DateTime.parse(now);
    DateTime lastDay = DateTime.parse(lastDayWotd);

    if(today.compareTo(lastDay) == 0){
      if(terminalPrinting) print('[SYS] Wotd done ($today = $lastDay)');
      setState(() {
        canWriteWotd = false;
        wotdDone = true;
      });
    } else {
      if(terminalPrinting) print('[SYS] Wotd not done (LastDay: $lastDay != Today: $today)');
      setState(() {
        canWriteWotd = true;
        wotdDone = false;
      });
    }

  }

  // ADMOB MANAGEMENT
  late BannerAd _bannerAd;
  late RewardedAd _rewardedAd;
  bool _isBannerAdReady = false;
  bool _isRewardedAdReady = false;

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          this._rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          if(terminalPrinting) print("[ERR] Failed to load a rewarded ad on 'home.dart': ${err.message}");
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  // VERSION MANAGEMENT
  statusCheck(NewVersion newVersion) async {
    newVersion.showAlertIfNecessary(context: context);
  }

  @override
  void dispose() {
    _rewardedAd.dispose();
    super.dispose();
  }

  @override
  void initState() {

    // VERSION MANAGEMENT
    final newVersion = NewVersion(
      iOSId: '',
      androidId: 'com.joa.encasillado',
    );
    if (appStarted ==  false) statusCheck(newVersion);

    _read_ever_played();

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
            if(terminalPrinting) print("[ERR] Failed to load a banner ad on 'home.dart': ${err.message}");
            _isBannerAdReady = false;
            ad.dispose();
          },
        ),
      );

      _bannerAd.load();
    }
    _loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    check_device();

    if (appStarted == false && everPlayed) {
      _read_colorblind();
      _read_darkmode();
      _read_infinite_score();
      _read_streak();
      _read_records();
      _read_stats();
      _read_trophies();
      _read_last_day_wotd();
      _read_consecutive_days_wotd();

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

    if (everPlayed) return Scaffold(
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
        if (currentPage == 0) gameBannerTwoButtons(context, '¡La palabra del día!', twitterBotButton(context), suggestButton(context)),
        if (currentPage == 1) gameBannerOneButton(context, 'Palabras infinitas', scoreButton(context)),
        if (currentPage == 0 && wotdDone == false) wotdLettersField(),
        if (currentPage == 1) infiniteLettersField(),
        if (currentPage == 0 && wotdDone == true) wotdDoneWaiting(),
        if (currentPage == 0 && wotdDone == false) Expanded(child: Text(""),),
        if (currentPage == 1) Expanded(child: Text(""),),
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
    else return IntroductionPage();


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
            // Si está al final de alguna fila
            if ((currentCellWotd == 5 || currentCellWotd == 10 || currentCellWotd == 15 || currentCellWotd == 20 || currentCellWotd == 25 || currentCellWotd == 30) && canWriteWotd == false) {
              // Si la palabra existe
              if (wotd_word_exists()) {
                // Si acierta la palabra
                if (wotd_check_word()) {
                  // Si no se marcó como acabado el juego
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
                      /** TROPHY: A LA PRIMERA */
                      if (atFirstTr == false){
                        setState(() {
                          totalTrophies++;
                          goldTrophies++;
                          atFirstTr = true;
                        });
                        _save_trophy('atfirsttr', 'gold');
                      }
                    }
                    if ((currentRowWotd+1) == 2) {
                      setState(() {
                        winsAtSecondWotd++;
                      });
                      _save_wotd_stats(2, winsAtSecondWotd, totalWotdGames);
                      /** TROPHY: A LA SEGUNDA */
                      if (atSecondTr == false){
                        setState(() {
                          totalTrophies++;
                          silverTrophies++;
                          atSecondTr = true;
                        });
                        _save_trophy('atsecondtr', 'silver');
                      }
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

                    check_wotd_days();
                  }
                  /** TROPHY FIRST PLAY */
                  if (firstPlayTr == false){
                    setState(() {
                      totalTrophies++;
                      bronzeTrophies++;
                      firstPlayTr = true;
                    });
                    _save_trophy('firstplaytr', 'bronze');
                  }

                  Navigator.pushNamed(context, '/wotd_end');
                }

                // Si no acierta la palabra
                else {
                  // Si estaba en el último intento
                  if (currentCellWotd == 30) {
                    // Si no se ha presentado la 7a oportunidad
                    if (extraTryWotd == false) {
                      /** TROPHY FIRST PLAY */
                      if (firstPlayTr == false) {
                        setState(() {
                          totalTrophies++;
                          bronzeTrophies++;
                          firstPlayTr = true;
                        });
                        _save_trophy('firstplaytr', 'bronze');
                      }

                      setState(() {
                        extraTryWotd = true;
                        finishedWotd = true;
                        wonGameWotd = false;
                        totalWotdGames++;
                        defeatsAtWotd++;
                      });

                      _save_wotd_stats(0, defeatsAtWotd, totalWotdGames);
                      check_wotd_days();

                      _showExtraTryDialogWotd();
                    }

                    // Si ya se ha presentado la 7a oportunidad
                    else {
                      // Si no se ha marcado como finalizado el juego
                      if (finishedWotd == false){
                        /** TROPHY FIRST PLAY */
                        if (firstPlayTr == false) {
                          setState(() {
                            totalTrophies++;
                            bronzeTrophies++;
                            firstPlayTr = true;
                          });
                          _save_trophy('firstplaytr', 'bronze');
                        }

                        setState(() {
                          finishedWotd = true;
                          wonGameWotd = false;
                          totalWotdGames++;
                          defeatsAtWotd++;
                        });

                        _save_wotd_stats(0, defeatsAtWotd, totalWotdGames);
                        check_wotd_days();
                      }
                      Navigator.pushNamed(context, '/wotd_end');
                    }
                  }

                  // Si no estaba en el último intento todavía
                  else {
                    setState(() {
                      currentRowWotd++;
                      canWriteWotd = true;
                    });
                  }
                }
              }

              // Si la palabra no existe
              else wordDoesNotExistFlushbar(context);
            }

            // Si ha acabado y aún no se ha medido el tiempo
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
            if ((currentCellInfinite == 5 || currentCellInfinite == 10 || currentCellInfinite == 15 || currentCellInfinite == 20 || currentCellInfinite == 25 || currentCellInfinite == 30) && canWriteInfinite == false) {
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
                    _save_trophy('firstplaytr', 'bronze');
                  }

                  Navigator.pushNamed(context, '/infinite_words_end');
                } else {
                  if (currentCellInfinite == 30) {
                    if (extraTryInfinite == false) {
                      /** TROPHY FIRST PLAY */
                      if (firstPlayTr == false) {
                        setState(() {
                          totalTrophies++;
                          bronzeTrophies++;
                          firstPlayTr = true;
                        });
                        _save_trophy('firstplaytr', 'bronze');
                      }

                      setState(() {
                        extraTryInfinite = true;
                        finishedInfinite = true;
                        wonGameInfinite = false;
                        endDateInfinite = DateTime.now();
                        playSecondsInfinite = endDateInfinite.difference(startDateInfinite);
                        totalInfiniteGames++;
                        defeatsAtInfinite++;
                        oldScore = infiniteScore;
                        oldStreak = streak;
                      });

                      _save_infinite_stats(0, defeatsAtInfinite, totalInfiniteGames);
                      infinite_update_score();

                      _showExtraTryDialogInfinite();
                    }

                    else {
                      if (finishedInfinite == false) {
                        /** TROPHY FIRST PLAY */
                        if (firstPlayTr == false) {
                          setState(() {
                            totalTrophies++;
                            bronzeTrophies++;
                            firstPlayTr = true;
                          });
                          _save_trophy('firstplaytr', 'bronze');
                        }

                        setState(() {
                          finishedInfinite = true;
                          wonGameInfinite = false;
                          endDateInfinite = DateTime.now();
                          playSecondsInfinite = endDateInfinite.difference(
                              startDateInfinite);
                          totalInfiniteGames++;
                          defeatsAtInfinite++;
                        });

                        _save_infinite_stats(
                            0, defeatsAtInfinite, totalInfiniteGames);
                        infinite_update_score();
                      }
                      Navigator.pushNamed(context, '/infinite_words_end');
                    }
                  }

                  else {
                    setState(() {
                      currentRowInfinite++;
                      canWriteInfinite = true;
                    });
                  }
                }
              }
              else wordDoesNotExistFlushbar(context);
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

    /** TROPHY: SECRET WORD */
    if (secretWordTr == false && inputWord == 'FELIZ'){
      setState(() {
        totalTrophies++;
        goldTrophies++;
        secretWordTr = true;
      });
      _save_trophy('secretwordtr', 'gold');
    }

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

    /** TROPHY: SECRET WORD */
    if (secretWordTr == false && inputWord == 'FELIZ'){
      setState(() {
        totalTrophies++;
        goldTrophies++;
        secretWordTr = true;
      });
      _save_trophy('secretwordtr', 'gold');
    }

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
      width: ((deviceHeight * 0.46) / 6),
      height: ((deviceHeight * 0.46) / 6),
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
        TextStyle(fontSize: ((deviceHeight * 0.335) / 6), color: appBlack),
      ),
    );
  }

  AnimatedContainer doneLetterCell(String char) {

    return AnimatedContainer(
      duration: Duration(milliseconds: 750),
      curve: Curves.easeInOutCirc,
      width: ((deviceHeight * 0.46) / 6),
      height: ((deviceHeight * 0.46) / 6),
      margin: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 6.0),
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: appGreen,
        border: Border.all(color: appSemiBlack, width: 0.0),
      ),
      child: Text(
        char,
        style:
        TextStyle(fontSize: ((deviceHeight * 0.335) / 6), color: appBlack),
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

  IntroductionScreen IntroductionPage() {
    return IntroductionScreen(
      showNextButton: true,
      showBackButton: true,
      pages: [
        PageViewModel(
          title: "¡Bienvenido a Encasillado!",
          body:
          "Vamos a dar un pequeño tour para aprender lo básico del juego. ¿Listo?",
          image: Image.asset(introIcon),
        ),
        PageViewModel(
          title: "¿Cómo jugar?",
          body:
          "Hay una palabra oculta, tienes 6 intentos para acertarla. Cada vez que pruebas "
              "una palabra sus letras cambiarán de color para indicar tu progreso: \n"
              "\nVerde: La palabra contiene esa letra en esa posición."
              "\nAmarillo: La palabra contiene esa letra pero no en esa posición."
              "\nGris: La palabra no contiene esa letra.",

          image: Image.asset(introExplanation1),
        ),
        PageViewModel(
          title: "El teclado",
          body:
          "Para probar una palabra debes pulsar la tecla 'PROBAR'. Las teclas del "
              "teclado también cambian de color al probar palabras.\n\n"
              "No son válidos los verbos conjugados ni los plurales. Las palabras "
              "con tilde se escriben sin ella.",
          image: Image.asset(introExplanation2),
        ),
        PageViewModel(
          title: "Dos modos de juego",
          body:
          "La Palabra del Día: Una palabra cada día. ¡La misma para todos los jugadores!\n\n"
              "Palabras Infinitas: Podrás jugar todas las palabras que quieras, además, "
              "tienes puntos y rachas para desafiarte a ti mismo y a tus amigos.",
          image: Image.asset(introExplanation3),
        ),
        PageViewModel(
          title: "Trofeos",
          body:
          "El juego tiene un apartado en el que puedes consultar tus trofeos. A "
              "medida que completes los desafíos indicados ganarás nuevos trofeos. "
              "¡Si los consigues todos obtendrás el trofeo de diamante!",
          image: Image.asset(introExplanation4),
        ),
      ],
      back: const Text('Anterior', style: TextStyle(color: Colors.grey),),
      next: const Text('Siguiente'),
      done: const Text('¡Vamos allá!', style: TextStyle(fontWeight: FontWeight.bold),),
      onDone: () {
        setState(() {
          everPlayed = true;
        });
        _save_ever_played();
      },
    );
  }

  void _showExtraTryDialogWotd() {
    if (_isRewardedAdReady == false) _loadRewardedAd();
    showDialog(

        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(adImg, scale: 18,),
                SizedBox(width: 5,),
                Text('Intento extra'),
              ],
            ),
            content: Text('Tienes la posibilidad de repetir el último intento '
                'si ves un anuncio:'),
            actions: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(height: 40,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.grey,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/wotd_end');
                              },
                              child: Text('NO')),),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: Container(height: 40,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: appMainColor,
                          ),
                          onPressed: () {
                            if (_isRewardedAdReady) {
                              _rewardedAd.show(onUserEarnedReward: (
                                  RewardedAd ad,
                                  RewardItem reward) {

                                // Retrocedemos las variables 1 intento
                                setState(() {
                                  finishedWotd = false;
                                  wonGameWotd = false;
                                  totalWotdGames--;
                                  defeatsAtWotd--;
                                });
                                _save_wotd_stats(
                                    0, defeatsAtWotd, totalWotdGames);

                                // Damos la recompensa
                                setState(() {
                                  currentCellWotd = 25;

                                  inputMatrixWotd[25] = "";
                                  inputMatrixWotd[26] = "";
                                  inputMatrixWotd[27] = "";
                                  inputMatrixWotd[28] = "";
                                  inputMatrixWotd[29] = "";

                                  colorsArrayWotd[25] = "B";
                                  colorsArrayWotd[26] = "B";
                                  colorsArrayWotd[27] = "B";
                                  colorsArrayWotd[28] = "B";
                                  colorsArrayWotd[29] = "B";

                                  canWriteWotd = true;
                                });
                                Navigator.pop(context);
                                rewardFlushbar(context);
                              });
                            }
                            else {
                              _loadRewardedAd();
                              loadingAdFlushbar(context);
                            }
                          },
                          child: Text('VALE'),
                        ),),
                    ),
                  ]
              ),
            ],
          );
        });
  }

  void _showExtraTryDialogInfinite() {
    if (_isRewardedAdReady == false) _loadRewardedAd();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(adImg, scale: 18,),
                SizedBox(width: 5,),
                Text('Intento extra'),
              ],
            ),
            content: Text('Tienes la posibilidad de repetir el último intento '
                'si ves un anuncio:'),
            actions: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(height: 40,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, '/infinite_words_end');
                            },
                            child: Text('NO')),),
                    ),
                    SizedBox(width: 5,),
                    Expanded(child: Container(height: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: appMainColor,
                        ),
                        onPressed: () {
                          if (_isRewardedAdReady) {
                            _rewardedAd.show(onUserEarnedReward: (RewardedAd ad,
                                RewardItem reward) {

                              // Retrocedemos las variables 1 intento
                              setState(() {
                                finishedInfinite = false;
                                wonGameInfinite = false;
                                totalInfiniteGames--;
                                defeatsAtInfinite--;
                                infiniteScore = oldScore;
                                streak = oldStreak;
                              });
                              _save_infinite_stats(
                                  0, defeatsAtInfinite, totalInfiniteGames);

                              // Damos la recompensa
                              setState(() {
                                currentCellInfinite = 25;

                                inputMatrixInfinite[25] = "";
                                inputMatrixInfinite[26] = "";
                                inputMatrixInfinite[27] = "";
                                inputMatrixInfinite[28] = "";
                                inputMatrixInfinite[29] = "";

                                colorsArrayInfinite[25] = "B";
                                colorsArrayInfinite[26] = "B";
                                colorsArrayInfinite[27] = "B";
                                colorsArrayInfinite[28] = "B";
                                colorsArrayInfinite[29] = "B";

                                canWriteInfinite = true;
                              });
                              Navigator.pop(context);
                              rewardFlushbar(context);
                            });
                          }
                          else {
                            _loadRewardedAd();
                            loadingAdFlushbar(context);
                          }
                        },
                        child: Text('VALE'),
                      ),),),
                  ]
              ),
            ],
          );
        });
  }

  Expanded wotdDoneWaiting(){

    final tomorrowDate = DateTime.now().add(new Duration(days: 1));
    final tomorrowDay = tomorrowDate.day.toString().padLeft(2, '0');;
    final tomorrowMonth = tomorrowDate.month.toString().padLeft(2, '0');;
    final tomorrowYear = tomorrowDate.year;
    final tomorrow = DateTime.parse("$tomorrowYear-$tomorrowMonth-$tomorrowDay 00:00:00.000000");

    final differenceSeconds = tomorrow.difference(DateTime.now()).inSeconds;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ya has jugado la palabra de hoy:',
            style: TextStyle(
              fontSize: 19,
              color: appBlack,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              fontFamily: 'RaleWay',
            ),
          ),
          SizedBox(height: 15,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              doneLetterCell(wotdArray[0]),
              doneLetterCell(wotdArray[1]),
              doneLetterCell(wotdArray[2]),
              doneLetterCell(wotdArray[3]),
              doneLetterCell(wotdArray[4]),
            ],
          ),
          SizedBox(height: 15,),
          Text(
            'Una palabra nueva en:',
            style: TextStyle(
              fontSize: 19,
              color: appBlack,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              fontFamily: 'RaleWay',
            ),
          ),
          SizedBox(height: 5,),
          SlideCountdownClock(
            duration: Duration(seconds: differenceSeconds),
            slideDirection: SlideDirection.Up,
            separator: ":",
            textStyle: TextStyle(
              fontSize: 19,
              color: appBlack,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
              fontFamily: 'RaleWay',
            ),
            shouldShowDays: false,
            onDone: () {
              setState(() {
                appStarted = false;
                canWriteWotd = true;
                wotdDone = false;
              });
              wotd_generate_word();
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
    );
  }

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
      }
      if (points10kTr == false && infiniteScore >= 10000){
        setState(() {
          totalTrophies++;
          silverTrophies++;
          points10kTr = true;
        });
        _save_trophy('points10ktr', 'silver');
      }
      if (points25kTr == false && infiniteScore >= 25000){
        setState(() {
          totalTrophies++;
          goldTrophies++;
          points25kTr = true;
        });
        _save_trophy('points25ktr', 'gold');
      }

      /** STREAK RECORDS */
      if (streak5Tr == false && streak >= 5){
        setState(() {
          totalTrophies++;
          bronzeTrophies++;
          streak5Tr = true;
        });
        _save_trophy('streak5tr', 'bronze');
      }
      if (streak10Tr == false && streak >= 10){
        setState(() {
          totalTrophies++;
          silverTrophies++;
          streak10Tr = true;
        });
        _save_trophy('streak10tr', 'silver');
      }
      if (streak25Tr == false && streak >= 25){
        setState(() {
          totalTrophies++;
          goldTrophies++;
          streak25Tr = true;
        });
        _save_trophy('streak25tr', 'gold');
      }

  }

  void infinite_reset_variables() {
    setState(() {
    newInfiniteGame = false;

    extraTryInfinite = false;

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
    if(terminalPrinting) print("[SYS] Infinite variables reset");
  }

}