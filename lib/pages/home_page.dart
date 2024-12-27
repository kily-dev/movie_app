import 'package:flutter/material.dart';
import 'package:movie_app/components/bottom_nav_bar.dart';
import 'package:movie_app/pages/category_page.dart';
import 'package:movie_app/pages/main_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<StatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    MainPage(),
    CategoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ))),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[200],
        child: Column(
          children: [
            //logo
            const SizedBox(height: 25.0),
            DrawerHeader(
              child: Image.asset('lib/assets/images/film.png'),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
              child: Divider(color: Colors.grey[400]),
            ),

            //other pages
            const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                )),

            const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About"),
                )),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
