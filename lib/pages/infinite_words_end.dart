import 'package:flutter/material.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class InfiniteWordsEnd extends StatefulWidget {
  @override
  _InfiniteWordsEndState createState() => _InfiniteWordsEndState();
}

class _InfiniteWordsEndState extends State<InfiniteWordsEnd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBarWithoutButtons(context),
      backgroundColor: appWhite,
      body: SizedBox(),
    );
  }
}