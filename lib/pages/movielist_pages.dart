import 'package:flutter/material.dart';


class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies to watch'),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            leading: new Icon(Icons.movie),
            title: new Text("Salt (2010)"),
          ),
          new ListTile(
            leading: new Icon(Icons.movie),
            title: new Text("The Man from U.N.C.L.E. (2015)"),
          ),
          new ListTile(
            leading: new Icon(Icons.movie),
            title: new Text("Skyfall (2012)"),
          ),
          new ListTile(
            leading: new Icon(Icons.movie),
            title: new Text("Mission: Impossible (1996)"),
          ),
          new ListTile(
            leading: new Icon(Icons.movie),
            title: new Text("Spectre (2015)"),
          ),
          new ListTile(
            leading: new Icon(Icons.movie),
            title: new Text("Mr. & Mrs. Smith (2005)"),
          ),
          new ListTile(
            leading: new Icon(Icons.movie),
            title: new Text("The Bourne Identity (2002)"),
          ),
        ],
      ),
    );
  }
}
