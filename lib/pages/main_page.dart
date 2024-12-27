import 'package:flutter/material.dart';
import 'package:movie_app/components/movie_tile.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'dart:convert';

class MainPage extends StatelessWidget {
  final tmdb = TMDB(
    //TMDB instance
    ApiKeys("096cbdf5d2c9f2b4cbae4eb8d946553b",
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOTZjYmRmNWQyYzlmMmI0Y2JhZTRlYjhkOTQ2NTUzYiIsIm5iZiI6MTczMzQ3NDk4MS40MDk5OTk4LCJzdWIiOiI2NzUyYmFhNTgwMmJhZDE2MDkxYWFjNWMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.FKwj74VLBCX_PmKN_WdsGyBrxaU1vqCBrcK44xV-9ds'), //ApiKeys instance with your keys,
  );

/*
  Future<Map> getTrendingMovies() async {
    
    Map result = await tmdb.v3.trending.getTrending();
    return result;
  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      scrollDirection: Axis.vertical,
      /*
      child: FutureBuilder(
        future: getTrendingMovies(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading spinner while waiting for the result
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Show error message if the Future fails
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              // Show the content of the Map when available
              Map data = snapshot.data!;
              // Output the map content as a string
              print(data['results'].toString());
              return Text("");
            } else {
              // If there's no data for any reason
              return Text("No data available");
          }
        }
      ),*/
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Search',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Icon(
                Icons.search,
                color: Colors.grey,
              )
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'Find your favorite movies..',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'Trending 🔥',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              Text(
                'See more',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.deepPurple),
              )
            ],
          ),
        ),
        //Trending
        const SizedBox(height: 10),

        FutureBuilder<Map<dynamic, dynamic>>(
          future: tmdb.v3.trending.getTrending(), // Pass the API call Future
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator()); // Loading indicator
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Error message
              } else {
                final results = snapshot.data!['results'];
                final movies = results
                    .where((item) => item['media_type'] == 'movie')
                    .toList();
                final tvShows = results
                    .where((item) => item['media_type'] == 'tv')
                    .toList();
                //debugPrint('Shape of JSON: ${jsonEncode(snapshot.data)}');
                // Inspect the shape of the data
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Movies',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                        height: 480,
                        child: ListView.builder(
                            itemCount: movies.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              debugPrint("Movie ${index}");
                              final movie = movies[index];
                              debugPrint(jsonEncode(movie));
                              return MovieTile(
                                id: movie["id"],
                                title: movie["title"],
                                posterPath: movie["poster_path"],
                              );
                            })),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'TV Shows',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                        height: 480,
                        child: ListView.builder(
                            itemCount: tvShows.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              debugPrint("TV Show ${index}");
                              final tvShow = tvShows[index];
                              debugPrint(jsonEncode(tvShow));
                              return MovieTile(
                                id: tvShow["id"],
                                title: tvShow["name"],
                                posterPath: tvShow["poster_path"],
                              );
                            })),
                  ],
                );

                /*
                  Text(
                    'Data:\n${jsonEncode(snapshot.data)}',
                    style: TextStyle(fontSize: 16),
                  ),*/
              }
            }
            // Default fallback (shouldn't occur in normal flow)
            return Text('Something went wrong!');
          },
        ),
/*
        Expanded(
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
            return MovieTile();
          })
        ),
*/
        const Padding(
          padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
          child: Divider(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
