/** APP VERSION */
const String appVersion = "2.0.0 Beta";

/** PERSISTENT DATA */
bool everPlayed = true;
bool colorBlind = false;
bool darkMode = false;
bool wantNotifications = true;
int streak = 0;
int infiniteScore = 0;
int totalInfiniteGames = 0;
int winsAtFirstInfinite = 0;
int winsAtSecondInfinite = 0;
int winsAtThirdInfinite = 0;
int winsAtFourthInfinite = 0;
int winsAtFifthInfinite = 0;
int winsAtSixthInfinite = 0;
int defeatsAtInfinite = 0;
int totalWotdGames = 0;
int winsAtFirstWotd = 0;
int winsAtSecondWotd = 0;
int winsAtThirdWotd = 0;
int winsAtFourthWotd = 0;
int winsAtFifthWotd = 0;
int winsAtSixthWotd = 0;
int defeatsAtWotd = 0;
int streakRecord = 0;
int scoreRecord = 0;
String lastDayWotd = '2000-01-01';
int consecutiveDaysWotd = 0;
bool wotdDone = false;
String? userName = '';
String? userId = '';

/** PERSISTENT TROPHIES */
int totalTrophies = 0; // 13 - not diamond
int diamondTrophies = 0;
int goldTrophies = 0;
int silverTrophies = 0;
int bronzeTrophies = 0;
bool allTrophiesTr = false;
bool streak25Tr = false;
bool streak10Tr = false;
bool streak5Tr = false;
bool atFirstTr = false;
bool atSecondTr = false;
bool points5kTr = false;
bool points10kTr = false;
bool points25kTr = false;
bool firstPlayTr = false;
bool days7wotdTr = false;
bool days15wotdTr = false;
bool days30wotdTr = false;
bool secretWordTr = false;

/** CONTROLLERS */
int homePage = 0;
int trophiesStatsPage = 0;
int markersPage = 0;
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
bool extraTryWotd = false;
bool extraTryInfinite = false;
bool terminalPrinting = false;
bool setNameWarned = false;
bool bdAlreadySynchronized = false;

/** OTHERS - NON PERSISTENT */
List<String> suggestedWords = [];

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

int oldScore = 0;
int oldStreak = 0;

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