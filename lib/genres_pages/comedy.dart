import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../details_page.dart';
import '../home.dart';
class genre_comedy extends StatefulWidget {

  @override
  _genre_comedyState createState() => _genre_comedyState();
}

class _genre_comedyState extends State<genre_comedy> {
  @override
  List filmaction=[];
  Future<void>loadactionmovies()async {
    Response response = await get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=c76aa0251cd073cf305fe2c0a51a4fd8&with_genres=35&primary_release_date.gte=1950-03-25&primary_release_date.lte=2021-11-31')) as Response;
    Map data = jsonDecode(response.body);
    setState(() {
      filmaction = data['results'];
      print(filmaction);
    });
  }
  initState(){
    super.initState();
    loadactionmovies();
  }
  int selected=-1;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor:Colors.black,
        shadowColor: Colors.black,
        toolbarOpacity: 0.8,
        title: Text('Genre : Comedy ',
            style: TextStyle(
              letterSpacing: 1,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            )),
        leading: FlatButton(
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body:ListView.builder(
          itemCount: filmaction.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                selected=index;
                setState(() {
                  if(selected==index)
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>filmdetails(id:filmaction[index]['id'], releasedate:filmaction[index]['release_date'], vote:filmaction[index]['vote_average'], overview:filmaction[index]['overview'],img:'https://image.tmdb.org/t/p/w500' +filmaction[index]['poster_path'],title:filmaction[index]['title'])));
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20 ),
                child: Container(
                  height:200,
                  width: 200,
                  child: Row(
                    children:[
                      Image.network('https://image.tmdb.org/t/p/w500'+filmaction[index]['poster_path']),
                      SizedBox(width:10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: Text(filmaction[index]['title'],
                                style:TextStyle(
                                  fontSize:15,
                                ),),
                            ),
                            SizedBox(height:10),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[700],
                                ),
                                Text(filmaction[index]['vote_average'].toString()),
                                SizedBox(width:10),
                                Text('('+filmaction[index]['release_date'].toString()+')',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),

                ),
              ),
            );
          }
      ),
    );
  }
}
