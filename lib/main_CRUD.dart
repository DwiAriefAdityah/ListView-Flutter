import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'daftar.dart';
import 'contactModel.dart';
import 'edit.dart';

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
  var loading = false;
  final list = new List<ContactModel>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get("http://188.166.177.2/flutter/list.php");
    if (response.statusCode == 200) {
      list.clear();
      final map = json.decode(response.body);
      final mapJson = map["data"];
      print(mapJson);
      mapJson.forEach((x) {
        final contact = new ContactModel(x['id'], x['nama'], x['hp']);
        list.add(contact);
      });
      setState(() {
        loading = false;
      });
    } else {
      print(response.statusCode);
      setState(() {
        loading = false;
      });
    }
  }

  void reloadState() {
    setState(() {
      this._lihatData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lihatData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Daftar(_lihatData)));
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
      body: RefreshIndicator(
        onRefresh: _lihatData,
        key: _refresh,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                x.nama,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(x.hp)
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    EditContact(x, _lihatData)));
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            dialogDelete(x.id);
                          },
                          icon: Icon(Icons.delete),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

//   //Fungsi DELETE

  dialogDelete(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  "Anda ingin menghapus kontak ini?",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text("No")),
                    SizedBox(
                      width: 16.0,
                    ),
                    InkWell(
                        onTap: () {
                          _delete(id);
                        },
                        child: Text("Yes")),
                  ],
                )
              ],
            ),
          );
        });
  }

  _delete(String id) async {
    String url = "http://188.166.177.2/flutter/delete.php";
    final response = await http.post(url, body: {"id": id});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
        _lihatData();
      });
    } else {
      print(pesan);
    }
  }
}