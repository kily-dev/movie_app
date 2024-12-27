import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String title;

  const CategoryTile({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Icon(
                  Icons.arrow_right,
                  size: 30,
                )
              ],
            ),
          )),
    );
  }
}
