import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/Film.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainScreen> {
  var urlImage = "https://image.tmdb.org/t/p/w780/";
  List<dynamic> listFilm = [];
  String url =
      "http://api.themoviedb.org/3/discover/movie?api_key=6292bf95dcc9ffdf348f8f49b6fcd696&language=en-US";

  @override
  void initState() {
    super.initState();
    getRequest();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Film hot"),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listFilm.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      '$urlImage${listFilm[index].backdropPath}',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${listFilm[index].title}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        const Text("data"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  Future<List<Film>?> getRequest() async {
    final response = await http.get(Uri.parse(url));
    setState(() {
      listFilm = json
          .decode(response.body)['results']
          .map((data) => Film.fromJson(data))
          .toList();
    });
  }
}
