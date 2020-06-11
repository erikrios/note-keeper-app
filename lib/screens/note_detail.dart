import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteDetailState();
  }
}

class _NoteDetailState extends State<NoteDetail> {
  final double _minimumPadding = 5.0;
  static final List<String> _priorities = [
    'High',
    'Low',
  ];
  String _priorityValue;

  @override
  void initState() {
    super.initState();
    _priorityValue = _priorities[1];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
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
            ListTile(
              title: DropdownButton(
                items: _priorities.map((String priority) {
                  return DropdownMenuItem<String>(
                    child: Text(priority),
                    value: priority,
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    _priorityValue = newValue;
                  });
                  debugPrint('User selected $_priorityValue');
                },
                style: textStyle,
                value: _priorityValue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
