import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'home.dart';
class UpcomingP extends StatefulWidget {
  const UpcomingP({Key? key}) : super(key: key);

  @override
  _UpcomingPState createState() => _UpcomingPState();
}

class _UpcomingPState extends State<UpcomingP> {
  @override
  List upcomingmovies=[];
  String date='';
  Future<void>loadupcomingmovies()async {
    Response response = await get(Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=c76aa0251cd073cf305fe2c0a51a4fd8&primary_release_date.gte=2022-03-25&primary_release_date.lte=2023-01-30')) as Response;
    Map data = jsonDecode(response.body);
    setState(() {
      upcomingmovies=data['results'];
      print(upcomingmovies);
    });
  }
  initState()
  {
    loadupcomingmovies();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
        toolbarOpacity: 0.8,
        title: Text('Upcoming Movies',
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
          itemCount: upcomingmovies.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20 ),
              child: Container(
                height:200,
                width: 300,
                child: Row(
                  children:[
                    Image.network('https://image.tmdb.org/t/p/w500'+upcomingmovies[index]['poster_path']),
                    SizedBox(width:10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('${index+1}'+'- ',style:TextStyle(fontSize: 16),),
                              Container(
                                width:195,
                                child: Text(upcomingmovies[index]['title'],
                                style: TextStyle(
                                  fontSize: 17,
                                )),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(22,8.0,0,0),
                            child: Row(
                              children: [
                                Text('Release date:',
                                style:TextStyle(
                                  fontSize: 15
                                )),
                                SizedBox(width:2),
                                Text('('+upcomingmovies[index]['release_date'].toString()+')',
                                style:TextStyle(
                                  color: Colors.grey,
                                  fontSize:15,
                                )),
                              ],

                            ),
                          ),

                        ],

                      ),
                    ),

                  ],
                ),

              ),
            );
          }
      ),
    );
  }
}
