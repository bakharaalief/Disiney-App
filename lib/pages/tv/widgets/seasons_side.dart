import 'package:disiney_app/pages/tv/widgets/season_item.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeasonsSide extends StatelessWidget {
  final List listSeason;
  SeasonsSide({this.listSeason});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           
           //title
           Text("Seasons", style: GoogleFonts.roboto(
               fontSize: 25,
               fontWeight: FontWeight.w800,
               color: ColorData().blue
           ),),

           SizedBox(height: 12,),
           
           Container(
             height: 250,
             child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                 itemCount: listSeason.length,
                 itemBuilder: (context, index) => SeasonItem(
                   title: listSeason[index]["name"],
                   posterPath: listSeason[index]["poster_path"],
                   episodeCount: listSeason[index]["episode_count"],
                   airDate: listSeason[index]["air_date"],
                 )),
           )
         ],
       ),
    );
  }
}
