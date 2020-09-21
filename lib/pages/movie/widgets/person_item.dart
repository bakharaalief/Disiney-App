import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonItem extends StatelessWidget {
  final String character, name, profilePath;
  PersonItem({this.character, this.name, this.profilePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //photo
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: profilePath != null ?

            Image.network("https://image.tmdb.org/t/p/w300/$profilePath",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ) : Container(
              width: 100,
              height: 100,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 10,),

          //name
          Text(name, style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 5,),

          Text(character, style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 15,
          ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      )
    );
  }
}
