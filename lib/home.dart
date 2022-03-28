import 'package:eager/home_widgets/trending_movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_widgets/movies_category.dart';
import 'home_widgets/movies_genre.dart';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Color(0xFF12153D)(for text ktextcolor)
  @override
  List <String>category=['Trending Movies','Upcoming Movies','Top Rated Movies'];

  List <String>genre=['Action','Comedy',' Drama','Fantasy','Horror','Mystery','Romance','Thriller','Western'];

  int selected=0;


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){},
          icon:Icon(Icons.menu,
          color: Colors.black,)
        ),
        actions:<Widget> [
        Icon(Icons.search,
        color: Colors.black,)
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          //Movie category
            Category( category:category),
            //2. Movie genre
             Genre(g:genre),
            //3.Movie caroussel
            //API TMDB GIVE US THE TRENDING MOVIES .
            Trending(),
            
          ],
        ),
    );
  }
}
