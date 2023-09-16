import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:watchinfo/models/movie_model.dart';
import 'package:watchinfo/screens/detailspage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String inputData = "";
bool showButton = false;
List<MovieModel> movies = [];
bool isLoading = false;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "WatchINFO",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 40),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.white,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Search for a Movie',
                  style: TextStyle(
                      // color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black38,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none),
                    hintText: "eg: The Dark Knight",
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.black),
                onSubmitted: (value) {
                  setState(() {
                    inputData = value;
                    print(inputData);
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 100,
                  child: FloatingActionButton(
                    onPressed: () {
                      fetchData(inputData);
                      isLoading = true;
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.green,
                          )
                        : Text("Search"),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void fetchData(String s) async {
    s = s.trim();
    print('fetchData called');
    final url = 'https://www.omdbapi.com/?s=$s&apikey=3063b506';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;

    final json = jsonDecode(body);

    List<MovieModel> res = [];

    Map<String, dynamic> jsonDataMap = json;

    List<dynamic> searchResults = jsonDataMap['Search'] == null
        ? [
            {"Title": "no item found"}
          ]
        : jsonDataMap['Search'];

    for (var result in searchResults) {
      MovieModel movie = await MovieModel.fromJson(result);
      res.add(movie);
    }

    setState(() {
      movies = res;
    });
    print("fetching complete");
    isLoading = false;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetaisPage(movies: movies)));
  }
}
