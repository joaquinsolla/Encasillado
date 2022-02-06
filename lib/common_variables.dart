// Current word database
List<String> selectedDatabase = [];

// Device size
double deviceHeight = 0;
double deviceWidth = 0;

// User settings
bool colorBlind = false;
bool nightMode = false;

// Cell control
int currentCell = 0;
int currentRow = 0;
bool canWrite = true;
bool finished = false;

// Word of the day letter by letter
List<String> wordOfTheDayArray = ["", "", "", "", ""];
String wordOfTheDayString = "";

// Stats
String infoStats = "";
String emojiStats = "";
DateTime startDate = DateTime.parse("2000-01-01 00:00:00.000000");
DateTime endDate = DateTime.parse("2000-01-01 00:00:00.000000");
Duration playSeconds = endDate.difference(startDate);

// URLs
String definitionURL = "https://dle.rae.es/";
String officialWordleURL = "https://www.powerlanguage.co.uk/wordle/";
String joshWardleURL = "https://www.powerlanguage.co.uk/";
String myInstagramURL = "https://instagram.com/joako.peke";
String myGitHubURL = "https://www.github.com/joaquinsolla";

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