import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Belajar ListView',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int value = 2;

  _addItem() {
    setState(() {
      value = value + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("List View"), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){},
          )
        ],
      ),
      body: ListView.builder(
          itemCount: this.value,
          itemBuilder: (context, index) => this._buildRow(index)),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }

  _buildRow(int index) {
    //return Text("Item " + index.toString());
    if (index %2== 0) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(index.toString())
        ),
          title: Text("Item " + index.toString()),
      );
        
     } else {
        return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.yellow,
          child: Text(index.toString())
        ),
          title: Text("Item " + index.toString()),
        );
      }
    
  }
}