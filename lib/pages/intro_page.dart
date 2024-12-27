import 'package:flutter/material.dart';
import 'package:movie_app/pages/home_page.dart';

// main color #212730  
// accent color #111818
// secondary color #F4F7FB  
 

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(
                'lib/assets/images/film.png',
                height: 240,
              ),
            ),
            //title
            const SizedBox(height: 40),

            const Text('Movie Hunt',
              style:  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            //sub title
            const SizedBox(height: 15),
            const Text('Stay up to date with the most recent movies using our Application',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            //start now button
            const SizedBox(height: 225),
            GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage())) ,
                child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(left: 100, right: 100, top: 25, bottom: 25),
                child: const Text(
                  'View Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              )
            )
          ],
        ),
      ),
    );
      
      
  }
}