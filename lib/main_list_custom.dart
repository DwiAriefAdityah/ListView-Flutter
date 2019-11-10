import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'contactModel.dart';
import 'daftar.dart';

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
  final list = new List<ContactModel>();

  Future<void> _lihatData() async {
    final response = await http.get("http://188.166.177.2/flutter/list.php");
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final mapJson = map["data"];
      //print(mapJson[2]);
      mapJson.forEach((x) {
        final contact = new ContactModel(x['id'], x['nama'], x['hp']);
        list.add(contact);
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[

            new Container(
              width: 190.0,
              height: 190.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("images/thanos.jpg")
                )
              )),

            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Text("A"),
              ),
              title: Text("Dwi Arief Adityah"),
              subtitle: Text("Teknologi Informasi 2016"),
              trailing: Icon(Icons.star),
            ),
          ],
          // padding: EdgeInsets.only(top: 40.0),
          
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
           MaterialPageRoute(builder: (context) => Daftar())
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      
      appBar: AppBar(
        title: Text("Daftar Kontak"),
        actions: <Widget>[
          
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                this._lihatData();
              });
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final dataList = list[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(dataList.id),
            ),

            title: Text(
              dataList.nama,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(dataList.hp),

          
             
          );
        },
      ),
    );
  }
}