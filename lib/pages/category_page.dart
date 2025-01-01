import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/components/category_tile.dart';
import 'package:tmdb_api/tmdb_api.dart';

class CategoryPage extends StatelessWidget {
  final tmdb = TMDB(
    //TMDB instance
    ApiKeys("096cbdf5d2c9f2b4cbae4eb8d946553b",
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOTZjYmRmNWQyYzlmMmI0Y2JhZTRlYjhkOTQ2NTUzYiIsIm5iZiI6MTczMzQ3NDk4MS40MDk5OTk4LCJzdWIiOiI2NzUyYmFhNTgwMmJhZDE2MDkxYWFjNWMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.FKwj74VLBCX_PmKN_WdsGyBrxaU1vqCBrcK44xV-9ds'), //ApiKeys instance with your keys,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text(
              'Movies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            SizedBox(
              height: 25,
            ),
            FutureBuilder<Map<dynamic, dynamic>>(
                future:
                    tmdb.v3.genres.getMovieList(), // Pass the API call Future
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Loading indicator
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Error message
                    } else {
                      final categories = snapshot.data!["genres"].toList();
                      debugPrint(jsonEncode(categories[0]['name']));
                      return SizedBox(
                        height: 125,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                                id: categories[index]['id'],
                                title: categories[index]['name'],
                                fullType: "Movies",
                                type: "movie");
                          },
                        ),
                      );
                    }
                  }
                  return Text('Something went wrong!');
                }),
            SizedBox(
              height: 50,
            ),
            Text(
              'TV Shows',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            SizedBox(
              height: 25,
            ),
            FutureBuilder<Map<dynamic, dynamic>>(
                future: tmdb.v3.genres.getTvlist(), // Pass the API call Future
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Loading indicator
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Error message
                    } else {
                      final categories = snapshot.data!["genres"].toList();
                      debugPrint(jsonEncode(categories[0]['name']));
                      return SizedBox(
                        height: 125,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                                id: categories[index]['id'],
                                title: categories[index]['name'],
                                fullType: "TV Shows",
                                type: "tv");
                          },
                        ),
                      );
                    }
                  }
                  return Text('Something went wrong!');
                }),
          ],
        ),
      ),
    );
  }
}
