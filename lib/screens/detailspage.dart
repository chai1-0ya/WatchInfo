import 'package:flutter/material.dart';
import 'package:watchinfo/models/movie_model.dart';
// import 'dart:async';

class DetaisPage extends StatelessWidget {
  final List<MovieModel> movies;
  const DetaisPage({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Results',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        body: GridView.count(
          padding: EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: List.generate(movies.length, (index) {
            final movie = movies[index];
            final name = movie.title;
            final imageUrl = movie.poster == 'N/A' || movie.poster == null
                ? 'https://img.icons8.com/ios-filled/50/no-image.png'
                : movie.poster;
            final year = movie.year;
            return Center(
                child: Column(
              children: [
                Image(
                  height: 180,
                  image: NetworkImage('$imageUrl'),
                ),
                Text('$name'),
                Text('$year')
              ],
            ));
          }),
        ));
  }
}
