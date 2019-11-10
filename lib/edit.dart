import 'dart:convert';
import 'package:flutter/material.dart';
import 'contactModel.dart';
import 'package:http/http.dart' as http;

class EditContact extends StatefulWidget {
  final ContactModel model;
  final VoidCallback reload;
  EditContact(this.model, this.reload);
  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _key = new GlobalKey<FormState>();
  String nama, hp;

  TextEditingController txtNama, txtHp;

  setup() {
    txtNama = TextEditingController(text: widget.model.nama);
    txtHp = TextEditingController(text: widget.model.hp);
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    } else {}
  }

  submit() async {
    String url = "http://188.166.177.2/flutter/edit.php";
    final response = await http
        .post(url, body: {"nama": nama, "hp": hp, "id": widget.model.id});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];

    if (value == 1) {
      setState(() {
        widget.reload();
        Navigator.pop(context);
      });
    } else {
      print(pesan);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: txtNama,
              onSaved: (e) => nama = e,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextFormField(
              controller: txtHp,
              onSaved: (e) => hp = e,
              decoration: InputDecoration(labelText: 'Hp'),
            ),
            MaterialButton(
              onPressed: () {
                check();
              },
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}