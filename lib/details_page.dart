import 'dart:convert';
import 'package:eager/service.dart';
import 'package:eager/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'home.dart';
class filmdetails extends StatefulWidget {
  String? overview;
  String? releasedate;
  double?vote;

  String?img;
  int?id;
  String? title;
  filmdetails ({required this.id,required this.releasedate,required this.vote, required this.overview,required this.img,required this.title}) ;
  @override
  State<filmdetails> createState() => _filmdetailsState();
}
class _filmdetailsState extends State<filmdetails> {
  List l=[];
   Future<void>loadmovieactors()async {
     Response response = await get(Uri.parse('https://api.themoviedb.org/3/movie/${this.widget.id}/credits?api_key=c76aa0251cd073cf305fe2c0a51a4fd8')) as Response;
     setState(() {
       Map data = jsonDecode(response.body);
       l=data['cast'];
     });
   }
    String x='';
  Map info={};
  Map val={};
  String?imdb;
    Future<String?>load()async {
      help instance = help(id:this.widget.id);
      await instance.getimdbid();
      setState(() {
        imdb=instance.imdbid;
      });
      return imdb;
    }
     List genre=[];
  String? ch;
    Future<void>loadmove()async{
      ch=(await load())! ;
      print(ch);
      Response response2 = await get(Uri.parse('http://www.omdbapi.com/?i=$ch&apikey=9803da5f')) as Response;
      Map data2=await jsonDecode(response2.body);
      print(data2);
      setState(() {
        info=data2;
        val=info['Ratings'][1];
        String ch=info['Genre'];
        genre=ch.split(",");
        print(genre);
      });
  }

  initState(){
    super.initState();
    loadmove();
    loadmovieactors();
  }

  @override
  Widget build(BuildContext context) {
    // it will provide us the total height and width
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // it will provide us 40% of our total height
            height: size.height * 0.5,
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.5-40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                    image: new DecorationImage(fit: BoxFit.fill,
                      image: new NetworkImage('${this.widget.img}'),
                  )
                  ),

                ),
                Positioned(
                bottom: 0,
                right: 0,
    child: Container(
    // it will cover 90% of our total width
    width: size.width * 0.9,
    height: 80,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(50),
    topLeft: Radius.circular(50),
    ),
    boxShadow: [
    BoxShadow(
    offset: Offset(0, 5),
    blurRadius: 50,
    color: Color(0xFF12153D).withOpacity(0.2),
    ),
    ],
    ),
    child: Padding(
    padding:
    const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Icon(Icons.star,
    color: Colors.yellow[700],),
    SizedBox(height: 5),
    RichText(
    text: TextSpan(
    style: TextStyle(color: Colors.black),
    children: [
    TextSpan(
    text: "${this.widget.vote.toString()}/",
    style: TextStyle(
    fontSize: 16, fontWeight: FontWeight.w600),
    ),
    TextSpan(text: "10\n"),
    TextSpan(
    text: "${info['imdbVotes']}",
    style: TextStyle(color: Colors.grey),
    ),
    ],
    ),
    ),
    ],
    ),
    // Rate this

    // Metascore
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
    color: Color(0xFF51CF66),
    borderRadius: BorderRadius.circular(2),
    ),
    child: Text(
    "${info['Metascore']}",
    style: TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    ),
    ),
    ),
    SizedBox(height:5),
    Text(
    "Metascore",
    style: TextStyle(
    fontSize: 16, fontWeight: FontWeight.w500),
    ),
    Text(
    "${info['Metascore']}"+'/100',
    style: TextStyle(color:Colors.grey),
    )
    ],
    ),
      //rotten tomatoes
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 40,
              width: 40,
              child: Image.asset('assets/tomato-14.png'),
          ),
          SizedBox(height:5),
          Text(
            "${val['Value']}",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500),
          ),

        ],
      )
    ],
    ),
    ),
    ),
    ),
    // Back Button
    SafeArea(child: IconButton(

      icon:Icon(Icons.arrow_back_ios_new,
      color: Colors.white,
    ), onPressed: () {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
    },
    ),

    ),
    ],
    ),
      ),
        Padding(
          padding: EdgeInsets.fromLTRB(20,5,0,0),
          child: Row(
            children: <Widget>[
              Expanded(
                //release date , runtime
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${this.widget.title}',
                      style: TextStyle(
                        fontSize: 20,

                      ),
                    ),
                    SizedBox(height:5),
                    //release date, runtime ..
                    Row(
                      children: <Widget>[
                        Text(
                          '${this.widget.releasedate}',
                          style: TextStyle(color:Colors.grey),
                        ),
                        SizedBox(width:20),
                        Text(
                          "${info['Rated']}",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "${info['Runtime']}",
                          style: TextStyle(color:Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        //movie genre
        Padding(
          padding: EdgeInsets.symmetric(vertical:10),
          child: SizedBox(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: genre.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical:5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Text('${genre[index]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF12153D).withOpacity(0.8),
                    ),
                  ),
                );
              }
            ),
          ),
        ),
          //plot
          Padding(
            padding:EdgeInsets.fromLTRB(20,0,0,0),
            child: Text(
              "Plot Summary",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('${this.widget.overview}',
              style: TextStyle(
                color: Color(0xFF737599),
                fontSize: 13,
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.fromLTRB(20,5,0,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Cast & Crew",
                style: Theme.of(context).textTheme.headline5,
              ),
              Container(
                height:100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: l.length,
                  itemBuilder: (context, index) =>Container(
                    margin: EdgeInsets.only(right:20),
                    width: 80,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: new NetworkImage('https://image.tmdb.org/t/p/w500' +
                              l[index]['profile_path']
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height:2),
                        Container(
                          height:27,
                          child: Text('${l[index]['name']}',
                            textAlign: TextAlign.center,
                            style:TextStyle(
                              fontSize: 13,
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ),
            ],
          ),
        ),
        ]
      ),
    );

  }
}
