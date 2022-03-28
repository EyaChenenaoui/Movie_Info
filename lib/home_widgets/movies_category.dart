import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home.dart';
import '../top_rated_movies.dart';
import '../upcoming_movie.dart';
class Category extends StatefulWidget {
  final List category;
  Category({required this.category});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  int selected=0;
  Widget build(BuildContext context) {
    return  Container(
      height:60,
      child: ListView.builder(
          itemCount: widget.category.length,
          scrollDirection: Axis.horizontal,
          itemBuilder:(context,index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              // 1.SELECT CATEGORY
              //gesture detector : to detect the slected category
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = index;
                    if (index == 0) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                    else if(index==1)
                      {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UpcomingP()));
                      }
                    else
                    {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => topratedP()));
                    }
                  },

                    );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(widget.category[index],
                      style:GoogleFonts.roboto(
                            color: selected==index?Color(0xFF12153D):Colors.black.withOpacity(0.4),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        ),
                          ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10),
                      child: Container(
                        height: 6,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // si la catégorie est sélectionnée donc la marqué avec ligne rouge
                          color:selected==index?Color(0xFFFE6D8E):Colors.transparent,
                        ),
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