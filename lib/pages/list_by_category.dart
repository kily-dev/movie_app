import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/components/movie_row.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ListByCategory extends StatelessWidget {
  final int id;
  final String name;
  final String type;
  final tmdb = TMDB(
    //TMDB instance
    ApiKeys("096cbdf5d2c9f2b4cbae4eb8d946553b",
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOTZjYmRmNWQyYzlmMmI0Y2JhZTRlYjhkOTQ2NTUzYiIsIm5iZiI6MTczMzQ3NDk4MS40MDk5OTk4LCJzdWIiOiI2NzUyYmFhNTgwMmJhZDE2MDkxYWFjNWMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.FKwj74VLBCX_PmKN_WdsGyBrxaU1vqCBrcK44xV-9ds'), //ApiKeys instance with your keys,
  );

  ListByCategory({
    required this.id,
    required this.name,
    required this.type,
    Key? key,
  }) : super(key: key);

  Future<Map<dynamic, dynamic>> getFuture() async {
    if (type == "tv") {
      return tmdb.v3.discover.getTvShows(withGenres: id.toString());
    } else {
      return tmdb.v3.discover.getMovies(withGenres: id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: ListView(
          children: [
            FutureBuilder<Map<dynamic, dynamic>>(
                future: getFuture(), // Pass the API call Future
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Loading indicator
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Error message
                    } else {
                      final movies = snapshot.data!["results"].toList();
                      debugPrint(jsonEncode(movies));
                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 50,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: movies.length /*categories.length*/,
                            itemBuilder: (context, index) {
                              String title_to_pass;
                              if (type == "tv") {
                                title_to_pass = movies[index]["name"];
                              } else {
                                title_to_pass = movies[index]["title"];
                              }
                              return MovieRow(
                                id: movies[index]["id"],
                                posterPath: movies[index]["poster_path"],
                                title: title_to_pass,
                                score: movies[index]["vote_average"],
                                type: type,
                              );
                            }),
                      );
                    }
                  }
                  return Text('Something went wrong!');
                }),
          ],
        ));
  }
}
