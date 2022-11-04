import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance/quotations?format=json&key=452bdfa2";

void main() async {
  runApp(MaterialApp(
    home: Home(),
  ));

}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.dataFromString(request));
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: const Text("\$ Coin Converter \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text("Carregando dados...",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                ),
              );
          }
        },
      ),
    );
  }
}
