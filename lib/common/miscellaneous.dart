/** APP VERSION*/
const String appVersion = "1.1.2 Beta";

/** PERSISTENT DATA*/
bool colorBlind = false;
bool darkMode = false;
//
int streak = 0;
int infiniteScore = 0;

/** CONTROLLERS */
int currentPage = 0;
bool appStarted = false;
bool canWriteWotd = true;
bool finishedWotd = false;
bool wonGameWotd = false;
bool canWriteInfinite = true;
bool finishedInfinite = false;
bool wonGameInfinite = false;
bool alreadyTimeMeasuredWotd = false;
bool timeStartedInfinite = false;
bool timeStartedWotd = false;
bool newInfiniteGame = false;
bool showAds = true;

/** DEVICE REQUIREMENTS */
double deviceHeight = 0;
double deviceWidth = 0;
double keyHeight = 0;

/** GAME-STATS VARIABLES */
String infoStatsInfinite = "";
String emojiStatsInfinite = "";
String infoStatsWotd = "";
String emojiStatsWotd = "";

DateTime startDateInfinite = DateTime.parse("2000-01-01 00:00:00.000000");
DateTime endDateInfinite = DateTime.parse("2000-01-01 00:00:00.000000");
DateTime startDateWotd = DateTime.parse("2000-01-01 00:00:00.000000");
DateTime endDateWotd = DateTime.parse("2000-01-01 00:00:00.000000");
Duration playSecondsInfinite = endDateInfinite.difference(startDateInfinite);
Duration playSecondsWotd = endDateInfinite.difference(startDateInfinite);

/** IN-GAME VARIABLES */
List<String> selectedDatabase = [];

int currentCellWotd = 0;
int currentRowWotd = 0;
int currentCellInfinite = 0;
int currentRowInfinite = 0;

List<String> wotdArray = ["", "", "", "", ""];
String wotdString = "";
List<String> infiniteArray = ["", "", "", "", ""];
String infiniteString = "";

List<String> greenKeysWotd = [];
List<String> yellowKeysWotd = [];
List<String> greyKeysWotd = [];

List<String> greenKeysInfinite = [];
List<String> yellowKeysInfinite = [];
List<String> greyKeysInfinite = [];

List<String> inputMatrixInfinite = [
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

List<String> inputMatrixWotd = [
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

List<String> colorsArrayInfinite = [
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

List<String> colorsArrayWotd = [
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