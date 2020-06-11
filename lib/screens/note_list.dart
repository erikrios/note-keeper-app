import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  double _minimumPadding = 5.0;
  List<int> dummyNumbers = List<int>.generate(100, (index) => index++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView.builder(
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
}
