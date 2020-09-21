import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OverviewSide extends StatelessWidget {
  final String overview;
  OverviewSide({this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Text("Overview", style: GoogleFonts.roboto(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: ColorData().blue
          ),),

          SizedBox(height: 12,),

          //content
          Text(overview, style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.white
          ),)
        ],
      ),
    );
  }
}
