import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> read(String filename) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    String text = await file.readAsString();
    print('- Read $text on $filename');
    return text;
  } catch (e) {
    print("- Couldn't read file $filename");
    return 'READ-ERROR';
  }
}

save(String filename, String content) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$filename');
  await file.writeAsString(content);
  print('- Saved $content on $filename');
}