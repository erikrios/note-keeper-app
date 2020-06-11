import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  final double _minimumPadding = 5.0;
  List<int> dummyNumbers = List<int>.generate(100, (index) => index++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Floating action button clicked');
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
}
