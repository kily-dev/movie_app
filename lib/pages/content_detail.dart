import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ContentDetail extends StatelessWidget {
  final tmdb = TMDB(
    //TMDB instance
    ApiKeys("096cbdf5d2c9f2b4cbae4eb8d946553b",
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOTZjYmRmNWQyYzlmMmI0Y2JhZTRlYjhkOTQ2NTUzYiIsIm5iZiI6MTczMzQ3NDk4MS40MDk5OTk4LCJzdWIiOiI2NzUyYmFhNTgwMmJhZDE2MDkxYWFjNWMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.FKwj74VLBCX_PmKN_WdsGyBrxaU1vqCBrcK44xV-9ds'), //ApiKeys instance with your keys,
  );

  final id;

  ContentDetail({
    required this.id, // Optional parameter
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Center(child: Text(id.toString())));
    throw UnimplementedError();
  }
}
