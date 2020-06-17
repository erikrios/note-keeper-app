import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_keeper_app/models/note.dart';
import 'package:note_keeper_app/utils/database_helper.dart';

class NoteDetail extends StatefulWidget {
  final String _appBarTitle;
  final Note note;

  NoteDetail(this.note, this._appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return _NoteDetailState(note, _appBarTitle);
  }
}

class _NoteDetailState extends State<NoteDetail> {
  final String _appBarTitle;
  final Note note;

  _NoteDetailState(this.note, this._appBarTitle);

  final double _minimumPadding = 5.0;
  static final List<String> _priorities = [
    'High',
    'Low',
  ];

  DatabaseHelper helper = DatabaseHelper();

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
    return WillPopScope(
      onWillPop: () {
        _navigateToList();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _appBarTitle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              _navigateToList();
            },
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToList() {
    Navigator.pop(context);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0]; // 'High'
        break;
      case 2:
        priority = _priorities[1]; // 'Low'
        break;
    }
    return priority;
  }

  // Update the title of Note object
  void updateTitle() {
    note.title = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {
    _navigateToList();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert operation
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      // Success
      // _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      // _showAlertDialog('Status', 'Note Saved Successfully');

    }
  }
}
