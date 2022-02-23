const String currentVersion = "1.0.2 beta";

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
int currentCell = 0;
int currentRow = 0;
bool canWrite = true;
bool finished = false;
bool wotdDone = false;

// Word of the day letter by letter
List<String> standardWordArray = ["", "", "", "", ""];
String standardWordString = "";
List<String> wordOfTheDayArray = ["", "", "", "", ""];
String wordOfTheDayString = "";

// Stats
bool wonGame = false;
String infoStats = "";
String emojiStats = "";
int streak = 0;
DateTime startDate = DateTime.parse("2000-01-01 00:00:00.000000");
DateTime endDate = DateTime.parse("2000-01-01 00:00:00.000000");
Duration playSeconds = endDate.difference(startDate);


// Content of each cell
List<String> inputMatrix = [
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

List<String> colorsArray = [
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