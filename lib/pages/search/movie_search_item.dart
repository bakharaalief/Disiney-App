import 'package:disiney_app/pages/movie/movie.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieSearchItem extends StatelessWidget {
  final String title, posterPath, releaseDate;
  MovieSearchItem({this.title, this.posterPath, this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.network("https://image.tmdb.org/t/p/w500/$posterPath",
              fit: BoxFit.cover,
              width: 100,
            ),
          ),

          SizedBox(width: 10,),

          Container(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                    color: ColorData().blue
                ),),

                SizedBox(height: 5,),

                Text(releaseDate.substring(0, 4), style: GoogleFonts.roboto(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white
                ),)
              ],
            ),
          )


        ],
      ),
    );
  }
}
