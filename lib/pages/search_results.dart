import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/components/movie_row.dart';
import 'package:tmdb_api/tmdb_api.dart';

class SearchResults extends StatelessWidget {
  final String query;

  final tmdb = TMDB(
    //TMDB instance
    ApiKeys("096cbdf5d2c9f2b4cbae4eb8d946553b",
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOTZjYmRmNWQyYzlmMmI0Y2JhZTRlYjhkOTQ2NTUzYiIsIm5iZiI6MTczMzQ3NDk4MS40MDk5OTk4LCJzdWIiOiI2NzUyYmFhNTgwMmJhZDE2MDkxYWFjNWMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.FKwj74VLBCX_PmKN_WdsGyBrxaU1vqCBrcK44xV-9ds'), //ApiKeys instance with your keys,
  );

  SearchResults({required this.query, Key? key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: ListView(
        children: [
          Center(
            child: Text(
              'Movies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          FutureBuilder<Map<dynamic, dynamic>>(
              future:
                  tmdb.v3.search.queryMovies(query), // Pass the API call Future
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading indicator
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Error message
                  } else {
                    final movies = snapshot.data!["results"].toList();
                    debugPrint(jsonEncode(movies));
                    return SizedBox(
                      height: (MediaQuery.of(context).size.height - 50) / 2,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: movies.length /*categories.length*/,
                          itemBuilder: (context, index) {
                            return MovieRow(
                              id: movies[index]["id"],
                              posterPath: movies[index]["poster_path"],
                              title: movies[index]["title"],
                              score: movies[index]["vote_average"],
                              type: "movie",
                            );
                          }),
                    );
                  }
                }
                return Text('Something went wrong!');
              }),
          Center(
            child: Text(
              'TV Shows',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          FutureBuilder<Map<dynamic, dynamic>>(
              future: tmdb.v3.search
                  .queryTvShows(query), // Pass the API call Future
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading indicator
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Error message
                  } else {
                    final tvShows = snapshot.data!["results"].toList();
                    debugPrint(jsonEncode(tvShows));
                    return SizedBox(
                      height: (MediaQuery.of(context).size.height - 50) / 2,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: tvShows.length /*categories.length*/,
                          itemBuilder: (context, index) {
                            return MovieRow(
                              id: tvShows[index]["id"],
                              posterPath: tvShows[index]["poster_path"],
                              title: tvShows[index]["name"],
                              score: tvShows[index]["vote_average"],
                              type: "tv",
                            );
                          }),
                    );
                  }
                }
                return Text('Something went wrong!');
              }),
        ],
      ),
    );
  }
}
