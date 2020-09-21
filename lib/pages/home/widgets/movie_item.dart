import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieItem extends StatelessWidget {
  final String title, posterPath;
  final double voteAverage;
  MovieItem({this.title, this.posterPath, this.voteAverage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.network("https://image.tmdb.org/t/p/w500/$posterPath")
          ),

          SizedBox(height: 5,),

          //title movie
          Text(title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: ColorData().blue
            ),
          ),

          SizedBox(height: 5,),

          //info 1
          Row(
            children: [
              Icon(Icons.star,
                size: 18,
                color: Colors.yellow,),

              SizedBox(width: 5,),

              Text("$voteAverage / 10", style: GoogleFonts.roboto(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: Colors.white
              ),)
            ],
          ),
        ],
      ),
    );
  }
}
