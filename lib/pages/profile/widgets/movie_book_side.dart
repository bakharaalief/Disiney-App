import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disiney_app/pages/movie/movie.dart';
import 'package:disiney_app/pages/profile/widgets/movie_item_bookmark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieBookSide extends StatelessWidget {
  final QuerySnapshot listData;
  MovieBookSide({this.listData});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Movie Book", style: GoogleFonts.roboto(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: Colors.white
          ),),

          SizedBox(height: 20,),

          Container(
            height: 220,
            child: listData.docs.isEmpty ? Container(
              width: double.infinity,
              child: Center(
                child: Text("Movie Bookmark empty", style: GoogleFonts.roboto(
                  color: Colors.white
                ),),
              ),
            ) :

            ListView.builder(
                itemCount: listData.size,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Movie(
                          id: listData.docs[index].get("movie_id"),
                        )
                    ));
                  },
                  child: MovieItemBookmark(
                    title: listData.docs[index].get("title"),
                    posterPath: listData.docs[index].get("poster_path"),
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}
