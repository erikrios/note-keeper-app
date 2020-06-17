import 'package:flutter/material.dart';
import 'package:note_keeper_app/models/note.dart';
import 'package:note_keeper_app/screens/note_detail.dart';
import 'package:note_keeper_app/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

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

  final double _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Floating action button clicked');
          _navigateToDetail(Note('', '', 2), 'Add Note');
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
                  backgroundColor: getPriorityColor(noteList[index].priority),
                  child: getPriorityIcon(noteList[index].priority),
                ),
                title: Text(
                  noteList[index].title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  noteList[index].date,
                ),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _delete(context, noteList[index]);
                  },
                ),
                onTap: () {
                  print('List Tile tapped');
                  _navigateToDetail(noteList[index], 'Edit Note');
                },
              ),
              color: Colors.white,
              elevation: 2.0,
            );
          },
          itemCount: count,
        ),
      ),
    );
  }

  void _navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return NoteDetail(note, title);
      },
    ));

    if (result == true) {
      updateListView();
    }
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

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
