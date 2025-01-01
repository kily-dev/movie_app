import 'package:flutter/material.dart';
import 'package:movie_app/components/next_page_container.dart';
import 'package:movie_app/pages/content_detail.dart';

class MovieRow extends StatelessWidget {
  final int id;
  final String title;
  final String? posterPath;
  final String type;
  final double score;

  const MovieRow(
      {required this.id,
      required this.type,
      required this.title,
      required this.score,
      this.posterPath,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NextPageContainer(
                  title: title,
                  child: ContentDetail(
                    id: id,
                    name: title,
                    type: type,
                  )),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomLeft: Radius.circular(24)),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500$posterPath', // Construct the full URL

                    fit: BoxFit.fill, // Adjust the image fit
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ), // Handle errors gracefully
                  ),
                ),
                SizedBox(
                  width: 125,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        Text("Score: $score",
                            style: TextStyle(
                                fontSize: 15,
                                decorationStyle: TextDecorationStyle.dotted))
                      ]),
                ),
                Container(
                    height: 200,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(24))),
                    child: Icon(
                      color: Colors.grey.shade800,
                      Icons.arrow_right,
                      size: 30,
                    ))
              ],
            ),
          ),
        ));
  }
}
