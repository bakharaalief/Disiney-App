import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieHeader extends StatelessWidget {
  final String title, backdropPath;
  MovieHeader({this.title, this.backdropPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("https://image.tmdb.org/t/p/w780/$backdropPath")
          )
      ),

      // black transparent
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 0.9],
              colors: [Colors.transparent, Colors.black],
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text(title, style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.white
                ),),
              ],
            ),
          )
      ),
    );
  }
}
