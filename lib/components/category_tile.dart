import 'package:flutter/material.dart';
import 'package:movie_app/components/next_page_container.dart';
import 'package:movie_app/pages/list_by_category.dart';

class CategoryTile extends StatelessWidget {
  final int id;
  final String title;
  final String type;

  const CategoryTile({
    required this.id,
    required this.title,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NextPageContainer(
                  title: "$title Movies",
                  child: ListByCategory(
                    id: id,
                    name: title,
                    type: type,
                  )),
            ),
          );
        },
        child: Padding(
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
        ));
  }
}
