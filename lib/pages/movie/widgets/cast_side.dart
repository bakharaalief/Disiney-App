import 'package:disiney_app/models/movie_cast.dart';
import 'package:disiney_app/pages/movie/widgets/person_item.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CastSide extends StatelessWidget {
  final List<MovieCast> listMovieCast;
  CastSide({this.listMovieCast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Text("Cast", style: GoogleFonts.roboto(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: ColorData().blue
          ),),

          SizedBox(height: 12,),

          //content
          Container(
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) =>
                    PersonItem(
                      character: listMovieCast[index].character,
                      name: listMovieCast[index].name,
                      profilePath: listMovieCast[index].profilePath,
                    )
            ),
          )

        ],
      ),
    );
  }
}
