import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List _listdata = [];

  Future _getdata() async {
    try {
      final respone =
          await http.get(Uri.parse('http://192.168.100.20/aPIFilm/nempo.php'));
      if (respone.statusCode == 200) {
        //print(respone.body);
        final data = jsonDecode(respone.body);
        setState(() {
          _listdata = data;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    //print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Movie"),
      ),
      body: ListView.builder(
        itemCount: _listdata.length,
        itemBuilder: ((context, index) {
          return const Card(
            child: ListTile(
              title: Text("data"),
            ),
          );
        }),
      ),
    );
  }
}
