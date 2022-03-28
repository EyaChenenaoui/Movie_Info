import 'dart:convert';

import 'package:eager/details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'home.dart';
class topratedP extends StatefulWidget {
  const topratedP({Key? key}) : super(key: key);

  @override
  _topratedPState createState() => _topratedPState();
}

class _topratedPState extends State<topratedP> {
  @override
  int selected=0;
  List topratedmovies=[];
  Future<void>loadtopratedmovies()async {
    Response response = await get(Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=c76aa0251cd073cf305fe2c0a51a4fd8')) as Response;
    Map data = jsonDecode(response.body);
    setState(() {
      topratedmovies=data['results'];
    });
  }
  initState()
  {
    loadtopratedmovies();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Top Rated Movies',
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1,
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
      body: ListView.builder(
                          itemCount: topratedmovies.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  selected=index;
                                  if(selected==index)
                                    {
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>filmdetails(id:topratedmovies[index]['id'], releasedate: topratedmovies[index]['release_date'], vote:topratedmovies[index]['vote_average'], overview: topratedmovies[index]['overview'],
                                          img:'https://image.tmdb.org/t/p/w500'+topratedmovies[index]['poster_path'],title:topratedmovies[index]['title']),));
                                    };
                                }
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20 ),
                                child: Container(
                                  height:200,
                                  width: 200,
                                  child: Row(
                                    children:[
                                      Image.network('https://image.tmdb.org/t/p/w500'+topratedmovies[index]['poster_path']),
                                      SizedBox(width:10),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('${index+1}'+'-',
                                                    style: TextStyle(
                                                      fontSize: 15
                                                    ),),
                                                    SizedBox(width:5),
                                                     Container(
                                                       width:190,
                                                       child: Text(topratedmovies[index]['title'],
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),),
                                                     ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow[700],
                                                ),
                                                Text(topratedmovies[index]['vote_average'].toString()),
                                                SizedBox(width: 5),
                                                Text(topratedmovies[index]['release_date'].toString(),
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
