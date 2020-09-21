import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disiney_app/pages/profile/widgets/movie_item_bookmark.dart';
import 'package:disiney_app/pages/tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TvBookSide extends StatelessWidget {
  final QuerySnapshot listData;
  TvBookSide({this.listData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tv Book", style: GoogleFonts.roboto(
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
                child: Text("Tv Bookmark empty", style: GoogleFonts.roboto(
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
                        builder: (context) => Tv(
                          id: listData.docs[index].get("tv_id"),
                        )
                    ));
                  },
                  child: MovieItemBookmark(
                    title: listData.docs[index].get("name"),
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
