import 'package:disiney_app/pages/movie/widgets/person_item.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CrewSide extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Text("Crew", style: GoogleFonts.roboto(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: ColorData().blue
          ),),

          SizedBox(height: 12,),

          //content
          PersonItem()
        ],
      ),
    );
  }
}
