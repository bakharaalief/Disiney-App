import 'package:disiney_app/models/movie_home.dart';
import 'package:disiney_app/pages/home/widgets/movie_item.dart';
import 'package:disiney_app/pages/movie/movie.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopulerMovieSide extends StatelessWidget {
  final List<MovieHome> listMovieHome;
  PopulerMovieSide({this.listMovieHome});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //sub title
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Populer Movie", style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white
              ),),

              Text("See All", style: GoogleFonts.roboto(
                  fontWeight: FontWeight.normal,
                  color: ColorData().blue
              ),)
            ],
          ),
        ),

        SizedBox(height: 20,),

        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Container(
            height: 250,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => GestureDetector(
                  child: MovieItem(
                    title: listMovieHome[index].title,
                    posterPath: listMovieHome[index].posterPath,
                    voteAverage: listMovieHome[index].voteAverage,
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Movie(
                        id: listMovieHome[index].id,
                      )
                    ));
                  },
                )
            ),
          )
        )

      ],
    );
  }
}
