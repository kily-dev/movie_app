import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ContentDetail extends StatelessWidget {
  final tmdb = TMDB(
    //TMDB instance
    ApiKeys("096cbdf5d2c9f2b4cbae4eb8d946553b",
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOTZjYmRmNWQyYzlmMmI0Y2JhZTRlYjhkOTQ2NTUzYiIsIm5iZiI6MTczMzQ3NDk4MS40MDk5OTk4LCJzdWIiOiI2NzUyYmFhNTgwMmJhZDE2MDkxYWFjNWMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.FKwj74VLBCX_PmKN_WdsGyBrxaU1vqCBrcK44xV-9ds'), //ApiKeys instance with your keys,
  );

  final int id;
  final String name;

  ContentDetail({
    required this.id,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: ListView(
        children: [
          FutureBuilder(
              future: tmdb.v3.movies.getDetails(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading indicator
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Error message
                  } else {
                    debugPrint(jsonEncode(snapshot.data));
                    var details = snapshot.data!;
                    return Column(
                      children: [
                        Image.network(
                          // ignore: prefer_interpolation_to_compose_strings
                          'https://image.tmdb.org/t/p/original' +
                              details[
                                  "backdrop_path"], // Construct the full URL

                          fit: BoxFit.fill, // Adjust the image fit
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ), // Handle errors gracefully
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 350,
                                child: Image.network(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  'https://image.tmdb.org/t/p/w500' +
                                      details[
                                          "poster_path"], // Construct the full URL

                                  fit: BoxFit.fill, // Adjust the image fit
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                    size: 50,
                                  ), // Handle errors gracefully
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Original Title: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          details["original_title"].toString(),
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Popularity: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          details["popularity"].toString(),
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                }
                return Text('Something went wrong!');
              })
        ],
      ),
    );
  }
}
