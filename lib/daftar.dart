import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Daftar extends StatefulWidget {
  Daftar(lihatData);

  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  String nama, hp;
   final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    }
  }

  //fungsi add db
  submit() async {
    String url = "http://188.166.177.2/flutter/add.php";
    final response = await http.post(url, body: {"nama": nama, "hp": hp});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      print(pesan);
      // setState(() {
      //   //widget.reload();
      //   Navigator.pop(context);
      // });
    } else {
      print(print);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TAMBAH PROFILE", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto',),),),
      body: Form(
        key: _key,
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
        
          SizedBox(height: 20.0),
            TextFormField(
              onSaved: (e) => nama = e,
              decoration: new InputDecoration(
                // labelText: 'Nama',
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(25.0),
                ),
              ),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey[800]),
              hintText: "Nama",
              fillColor: Colors.white70),
            ),
          
          SizedBox(height: 20.0),
            new TextFormField(
              onSaved: (e) => hp = e,
              decoration: new InputDecoration(
                // labelText: 'Handphone',
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(25.0),
                ),
              ),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey[800]),
              hintText: "No. Hp",
              fillColor: Colors.white70),
            ),
          
          SizedBox(height: 10.0,),
          new Container(
            margin: EdgeInsets.only(left: 120.0),
            padding: EdgeInsets.only(left: 80.0),
            width: 200.0,
            // height: 50.0,
            child: RaisedButton(
            padding: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
              side: BorderSide(color: Colors.blue),
            ),        
            color: Colors.blue,
            onPressed: () {
              check();
            },
            child: const Text('Tambah', style: TextStyle(fontSize: 20, color: Colors.white)))
          ),

          

          ],
        ) 
        
      ),
      ),
    );
  }
}