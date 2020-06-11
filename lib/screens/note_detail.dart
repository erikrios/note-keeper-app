import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteDetailState();
  }
}

class _NoteDetailState extends State<NoteDetail> {
  final double _minimumPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Note',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: _minimumPadding * 2,
          top: _minimumPadding * 3,
          right: _minimumPadding * 2,
        ),
        child: ListView(
          children: [
            
          ],
        ),
      ),
    );
  }
}
