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

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _minimumPadding * 3,
                bottom: _minimumPadding * 3,
              ),
              child: TextField(
                controller: titleController,
                style: textStyle,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String value) {
                  debugPrint('Something changed in Title Text Field');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _minimumPadding * 3,
                bottom: _minimumPadding * 3,
              ),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String value) {
                  debugPrint('Something changed in Description Text Field');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _minimumPadding * 3,
                bottom: _minimumPadding * 3,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Save state button clicked');
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Delete state button clicked');
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
