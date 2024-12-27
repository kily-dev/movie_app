import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final String title;
  final String? posterPath;

  const MovieTile({
    required this.title,
    this.posterPath, // Optional parameter
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 25),
      width: 250,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //movie poster
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
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
        // title
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              //padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  )),
              child: const Icon(
                Icons.arrow_right_rounded,
                size: 50,
                color: Colors.white,
              ),
            )
          ],
        )
      ]),
    );
  }
}