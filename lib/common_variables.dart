const String currentVersion = "1.0.6";

int currentPage = 0;
bool appStarted = false;

// Current word database
List<String> selectedDatabase = [];

// Device size
double deviceHeight = 0;
double deviceWidth = 0;
double keyHeight = 0;

// User settings
bool colorBlind = false;
bool darkMode = false;

// Cell control
int currentCellInfinite = 0;
int currentRowInfinite = 0;
bool canWriteInfinite = true;
bool finishedInfinite = false;

int currentCellWotd = 0;
int currentRowWotd = 0;
bool canWriteWotd = true;
bool finishedWotd = false;

// Correct words
List<String> infiniteArray = ["", "", "", "", ""];
String infiniteString = "";
List<String> wotdArray = ["", "", "", "", ""];
String wotdString = "";

// Stats
bool wonGameInfinite = false;
bool wonGameWotd = false;
String infoStatsInfinite = "";
String emojiStatsInfinite = "";
String infoStatsWotd = "";
String emojiStatsWotd = "";
int streak = 0;
int pointsInfinite = 0;
DateTime startDateInfinite = DateTime.parse("2000-01-01 00:00:00.000000");
DateTime endDateInfinite = DateTime.parse("2000-01-01 00:00:00.000000");
DateTime startDateWotd = DateTime.parse("2000-01-01 00:00:00.000000");
DateTime endDateWotd = DateTime.parse("2000-01-01 00:00:00.000000");
Duration playSecondsInfinite = endDateInfinite.difference(startDateInfinite);
Duration playSecondsWotd = endDateInfinite.difference(startDateInfinite);
bool alreadyTimeMeasuredInfinite = false;
bool alreadyTimeMeasuredWotd = false;
bool alreadyPointsCalculatedInfinite = false;
bool timeStartedInfinite = false;
bool timeStartedWotd = false;


// Content of each cell
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