import 'dart:convert';
import 'package:eager/details_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:math' as math;
import 'package:eager/details_page.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  _TrendingState createState() => _TrendingState();
}



class _TrendingState extends State<Trending> {
  List trend=[];
  String id='';
  late PageController _pageController;
  int initialpage=0;
  int selected=-1;
  final String api_key='c76aa0251cd073cf305fe2c0a51a4fd8';
  @override

  Future<void>loadmovies()async {
      Response response = await get(Uri.parse('https://api.themoviedb.org/3/trending/movie/day?api_key=c76aa0251cd073cf305fe2c0a51a4fd8')) as Response;
      Map data = jsonDecode(response.body);
   setState(() {
  trend=data['results'];
   });
  }
    initState(){
      loadmovies();
      super.initState();
      _pageController=PageController(
        viewportFraction: 0.8,
        initialPage: initialpage,
      );

    }
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child:AspectRatio(
          aspectRatio: 0.85,
          child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  initialpage = value;
                });
              },
            controller: _pageController,
              physics: ClampingScrollPhysics(),
              itemCount: trend.length,
              scrollDirection: Axis.horizontal,

              itemBuilder:(context,index) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      selected=index;
                      if(selected==index)
                      {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>filmdetails(id:trend[index]['id'], releasedate: trend[index]['release_date'], vote:trend[index]['vote_average'], overview: trend[index]['overview'],img:'https://image.tmdb.org/t/p/w500' + trend[index]['poster_path'],title:trend[index]['title'])));
                      }
                    });

                  },
                  child: AnimatedBuilder(
                    animation: _pageController,
                    builder: (context,child) {
                      double value = 0;
                      if (_pageController.position.haveDimensions) {
                         value =index.toDouble()-(_pageController.page??0);
                        value = (value * 0.038).clamp(-1, 1);
                      }
                      return AnimatedOpacity(
                        duration: Duration(milliseconds: 350),
                        opacity: initialpage == index ? 1 : 0.5,
                        child: Transform.rotate(
                          angle: math.pi * value,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 4,
                                          color: Colors.black26,
                                        ),
                                        ],
                                        image: new DecorationImage(fit: BoxFit.fill,
                                          image: new NetworkImage(
                                              'https://image.tmdb.org/t/p/w500' +
                                                  trend[index]['poster_path']),),
                                      )

                                  ),
                                  ),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(trend[index]['title'],
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow[700],
                                        ),
                                        Text(trend[index]['vote_average'].toString(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyText2),
                                      ]
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                );
              }
                ),

                ),
                );
  }
}
