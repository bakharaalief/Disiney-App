import 'dart:math';

import 'package:disiney_app/datas/fetch_api.dart';
import 'package:disiney_app/models/movie_home.dart';
import 'package:disiney_app/pages/movie/movie.dart';
import 'package:disiney_app/pages/search/movie_search_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearch extends SearchDelegate{

  List <MovieHome> listMovie;
  
  Future <List<MovieHome>> fetchSearch(String data) async {
    return await FetchApi().fetchSearchMovie(data);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.black,
      textTheme: theme.textTheme.copyWith(
        headline6: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    return listMovie.length == 0 ?

    Container(
      color: Colors.black,
      child: Center(
        child: Text("Data Not Found", style: GoogleFonts.roboto(
            color: Colors.white
        ),),
      ),
    ) :

    Container(
      color: Colors.black,
      height: double.infinity,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: listMovie.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Movie(id: listMovie[index].id,))
              );
            },
            child: MovieSearchItem(
              title: listMovie[index].title,
              posterPath: listMovie[index].posterPath,
              releaseDate: listMovie[index].releaseDate,
            ),
          )
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty ?

    Container(
      color: Colors.black,
      child: Center(
        child: Text("search movie", style: GoogleFonts.roboto(
          color: Colors.white
        ),),
      ),
    ) :

    FutureBuilder(
      future: fetchSearch(query),
      builder: (context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Container(
            color: Colors.black,
            child: Center(
              child: Text("Loadinggg", style: GoogleFonts.roboto(
                color: Colors.white
              ),),
            ),
          );
        }
        else if(snapshot.data.length == 0){
          return Container(
            color: Colors.black,
            child: Center(
              child: Text("Movie Not Found", style: GoogleFonts.roboto(
                  color: Colors.white
              ),),
            ),
          );
        }
        else{
          listMovie = snapshot.data;

          return Container(
              color: Colors.black,
              height: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Movie(id: snapshot.data[index].id,))
                      );
                    },
                    child: MovieSearchItem(
                      title: snapshot.data[index].title,
                      posterPath: snapshot.data[index].posterPath,
                      releaseDate: snapshot.data[index].releaseDate,
                    ),
                  )
              )
          );
        }
        return null;
      }
    );
  }

}