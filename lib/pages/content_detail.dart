import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ContentDetail extends StatelessWidget {
  final tmdb = TMDB(
    //TMDB instance
    ApiKeys("096cbdf5d2c9f2b4cbae4eb8d946553b",
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOTZjYmRmNWQyYzlmMmI0Y2JhZTRlYjhkOTQ2NTUzYiIsIm5iZiI6MTczMzQ3NDk4MS40MDk5OTk4LCJzdWIiOiI2NzUyYmFhNTgwMmJhZDE2MDkxYWFjNWMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.FKwj74VLBCX_PmKN_WdsGyBrxaU1vqCBrcK44xV-9ds'), //ApiKeys instance with your keys,
  );

  final int id;
  final String name;
  final String type;

  final numberFormatter = NumberFormat("#,##0");
  final millionFormatter = NumberFormat("#,##0.0M");
  final billionFormatter = NumberFormat("#,##0.0B");

  ContentDetail({
    required this.id,
    required this.name,
    required this.type,
    super.key,
  });

  String formatAmount(int? amount) {
    if (amount == null || amount == 0) {
      return "No Information";
    }
    if (amount >= 1000000000) {
      // Format as billions
      return billionFormatter.format(amount / 1000000000);
    } else if (amount >= 1000000) {
      // Format as millions
      return millionFormatter.format(amount / 1000000);
    } else {
      // Format with commas
      return numberFormatter.format(amount);
    }
  }

  Future<Map<dynamic, dynamic>> getFuture() async {
    if (type == "tv") {
      return tmdb.v3.tv.getDetails(id);
    } else {
      return tmdb.v3.movies.getDetails(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: ListView(
        children: [
          FutureBuilder(
              future: getFuture(),
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
                          details["original_title"]?.toString() ?? name,
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
                                height: 200,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
                                  child: Image.network(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'https://image.tmdb.org/t/p/w500' +
                                        details["poster_path"],

                                    fit: BoxFit.fill, // Adjust the image fit
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                      size: 200,
                                    ), // Handle errors gracefully
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Popularity: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          details["popularity"].toString(),
                                          style: TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Release Date: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          details["release_date"].toString(),
                                          style: TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Budget: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          formatAmount(details["budget"]),
                                          style: TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Box Office: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          formatAmount(details["revenue"]),
                                          style: TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Runtime: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "${details["runtime"]} minutes",
                                          style: TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Language: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          details["spoken_languages"][0]
                                              ["english_name"],
                                          style: TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 48),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Official Website: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    details["homepage"].toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Overview:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(details["overview"]),
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
