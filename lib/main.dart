import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: BelajarList(),
  ));
}

//setiap ganjil biru, genap kuning


class BelajarList extends StatefulWidget {
  @override
  _BelajarListState createState() => _BelajarListState();
}

class _BelajarListState extends State<BelajarList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View"), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){},
          )
        ],
      ),
      drawer: Drawer(),
      body: ListView(
        children: <Widget>[

          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("D"),
            ),
            title: Text("Dwi Arief Adityah"),
            subtitle: Text("Teknologi Informasi 2016"),
            trailing: Icon(Icons.star),
          ),

          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Text("A"),
            ),
            title: Text("Arif Azizi"),
            subtitle: Text("Teknologi Informasi 2016"),
            trailing: Icon(Icons.star),
          )

        ],
      )
    );
  }
}

// C:\Users\Dwi Arief Aditya\AppData\Local\Programs\Python\Python36\Scripts\;C:\Users\Dwi Arief Aditya\AppData\Local\Programs\Python\Python36\;C:\Users\Dwi Arief Aditya\AppData\Local\Programs\Python\Launcher\;C:\Users\Dwi Arief Aditya\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Dwi Arief Aditya\AppData\Roaming\Composer\vendor\bin;C:\flutter\bin;C:\Windows\System32;C:\Program Files\Git\git-cmd.exe;