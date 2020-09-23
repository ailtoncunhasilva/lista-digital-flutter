import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lista Digital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _toDoList = ['Ailton', 'Danielle'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Lista Digital'),
            backgroundColor: Colors.blue[900],
            centerTitle: true),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(8, 1, 1, 8),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Novo ítem',
                          labelStyle: TextStyle(color: Colors.blue[900]))),
                ),
                RaisedButton(
                    color: Colors.blue[900],
                    child: Text('ADICIONAR'),
                    textColor: Colors.white,
                    onPressed: () {})
              ]),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: _toDoList.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(_toDoList[index]),
                  );
                }
              )
            )
          ],
        ));
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
