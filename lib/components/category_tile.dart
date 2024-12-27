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
          width: 220,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    overflow: TextOverflow.clip,
                  ),
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
