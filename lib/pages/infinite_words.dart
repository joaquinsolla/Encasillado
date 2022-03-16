import 'package:flutter/material.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class InfiniteWords extends StatefulWidget {
  @override
  _InfiniteWordsState createState() => _InfiniteWordsState();
}

class _InfiniteWordsState extends State<InfiniteWords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBarWithoutButtons(context),
      backgroundColor: appWhite,
      body: SizedBox(),
    );
  }
}