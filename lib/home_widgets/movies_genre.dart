import 'package:eager/genres_pages/drama.dart';
import 'package:eager/genres_pages/fanatsy.dart';
import 'package:eager/genres_pages/horror.dart';
import 'package:eager/genres_pages/mystery.dart';
import 'package:eager/genres_pages/romance.dart';
import 'package:eager/genres_pages/western.dart';
import 'package:flutter/material.dart';
import '../genres_pages/action.dart';
import '../genres_pages/comedy.dart';
import '../genres_pages/thriller.dart';
class Genre extends StatefulWidget {
  final List g;

  const Genre({required this.g});

  @override
  State<Genre> createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  @override
  int selected=-1;
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
          itemCount: widget.g.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selected = index;
                  if (index == 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => genre_action()));
                  }
                  else if(index==1)
                    {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => genre_comedy()));
                }
         else if(index==2)
    {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => genre_drama()));
    }
                  else if(index==3)
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => genre_fantasy()));
                  }
                  else if(index==4)
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => genre_horror()));
                  }
                  else if(index==5)
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => genre_mystery()));
                  }
                  else if(index==6)
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => genre_romance()));
                  }
                  else if(index==7)
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => genre_thriller()));
                  }
                  else
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => genre_western()));
                  }
                }
                );
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical:5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black12),
                  color: selected==index?Colors.yellowAccent[700]:Colors.transparent,
                ),
                child: Text(widget.g[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF12153D).withOpacity(0.8),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}