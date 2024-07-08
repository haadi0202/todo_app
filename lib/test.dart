import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReorderableListViewExample(),
    );
  }
}

class ReorderableListViewExample extends StatefulWidget {
  @override
  _ReorderableListViewExampleState createState() =>
      _ReorderableListViewExampleState();
}

class _ReorderableListViewExampleState
    extends State<ReorderableListViewExample> {
  final List<String> _items =
      List<String>.generate(10, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reorderable List View Example'),
      ),
      body: Theme(
        data: ThemeData(
          canvasColor:
              Colors.transparent, // Background color of the dragged item
        ),
        child: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final String item = _items.removeAt(oldIndex);
              _items.insert(newIndex, item);
            });
          },
          children: _items.map((String item) {
            return Container(
              key: ValueKey(item),
              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                item,
                style: TextStyle(fontSize: 18.0),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
