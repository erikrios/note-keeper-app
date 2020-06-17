import 'package:flutter/material.dart';
import 'package:note_keeper_app/models/note.dart';
import 'package:note_keeper_app/screens/note_detail.dart';
import 'package:note_keeper_app/utils/database_helper.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Floating action button clicked');
          _navigateToDetail('Add Note');
        },
        tooltip: 'Add note',
        child: Icon(Icons.add),
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: _minimumPadding * 2, right: _minimumPadding * 2),
        child: ListView.builder(
          padding: EdgeInsets.only(
              top: _minimumPadding * 2, bottom: _minimumPadding * 2),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Icon(
                    Icons.arrow_right,
                  ),
                ),
                title: Text(
                  'This is title ${dummyNumbers[index]}',
                ),
                subtitle: Text(
                  'This is subtitle ${dummyNumbers[index]}',
                ),
                trailing: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: () {
                  print('${dummyNumbers[index]} tapped');
                  _navigateToDetail('Edit Note');
                },
              ),
              color: Colors.white,
              elevation: 2.0,
            );
          },
          itemCount: dummyNumbers.length,
        ),
      ),
    );
  }

  void _navigateToDetail(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return NoteDetail(title);
        },
      ),
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }
}
