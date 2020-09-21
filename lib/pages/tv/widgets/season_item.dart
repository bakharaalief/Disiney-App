import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeasonItem extends StatelessWidget {
  final String title, posterPath, airDate;
  final int episodeCount;
  SeasonItem({this.title, this.posterPath, this.episodeCount, this.airDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //poster movie
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: posterPath != null ? Image.network("https://image.tmdb.org/t/p/w500/$posterPath") :

                Container(
                  width: 120,
                  height: 180,
                  color: Colors.white,
                )
            ,
          ),

          SizedBox(height: 5,),

          //title movie
          Text(title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18
            ),
          ),

          SizedBox(height: 5,),

          Text(airDate.substring(0,4), style: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.white
          ),),

          SizedBox(height: 5,),

          //info 1
          Row(
            children: [
              Icon(Icons.tv,
                size: 18,
                color: Colors.white,),

              SizedBox(width: 5,),

              Text("$episodeCount", style: GoogleFonts.roboto(
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
