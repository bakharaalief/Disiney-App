import 'dart:convert';

import 'package:disiney_app/models/movie_cast.dart';
import 'package:disiney_app/models/movie_detail.dart';
import 'package:disiney_app/models/movie_home.dart';
import 'package:disiney_app/models/tv_detail.dart';
import 'package:disiney_app/pages/tv/tv.dart';
import "package:http/http.dart" as http;


class FetchApi{
  final String _apiKey = "fbe7897be12403abb6541f18a7986330";

  List<MovieHome> listTrending;
  List<MovieHome> listPopulerMovie;
  List<MovieHome> listPopulerTv;
  List<MovieHome> listSearchMovie;
  MovieDetail movieDetail;
  TvDetail tvDetail;
  List<MovieCast> listMovieCast;
  List<MovieCast> listTvCast;

  Future<void> fetchTrending() async {
    final respone = await http.get("https://api.themoviedb.org/3/trending/all/day?api_key=$_apiKey");

    listTrending = List<MovieHome>();

    if(respone.statusCode == 200){
      var json = jsonDecode(respone.body);
      var result = json["results"];

      result.forEach((e){

        if(e["backdrop_path"] != null &&  e["release_date"] != null){
          MovieHome _data = new MovieHome(
              id: e["id"],
              posterPath: e["poster_path"],
              backdropPath: e["backdrop_path"],
              title: e["title"],
              genreIds: e["genre_ids"],
              voteAverage: double.parse(e["vote_average"].toString()),
              releaseDate: e["release_date"],
              mediaType: e["media_type"]
          );

          listTrending.add(_data);
        }
      });
    }
    else{
      throw Exception();
    }
  }

  Future<void> fetchMovie() async {
    final respone = await http.get("https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey&language=en-US&page=1");

    listPopulerMovie = List<MovieHome>();

    if(respone.statusCode == 200){
      var json = jsonDecode(respone.body);
      var result = json["results"];

      result.forEach((e){

        MovieHome _data = new MovieHome(
          id: e["id"],
          posterPath: e["poster_path"],
          backdropPath: e["backdrop_path"],
          title: e["title"],
          genreIds: e["genre_ids"],
          voteAverage: double.parse(e["vote_average"].toString()),
          releaseDate: e["release_date"]
        );

        listPopulerMovie.add(_data);
      });
    }
    else{
      throw Exception();
    }
  }

  Future<void> fetchTv() async {
    final respone = await http.get("https://api.themoviedb.org/3/tv/popular?api_key=$_apiKey&language=en-US&page=1");

    listPopulerTv = List<MovieHome>();

    if(respone.statusCode == 200){
      var json = jsonDecode(respone.body);
      var result = json["results"];

      result.forEach((e){

        MovieHome _data = new MovieHome(
            id: e["id"],
            posterPath: e["poster_path"],
            backdropPath: e["backdrop_path"],
            title: e["name"],
            genreIds: e["genre_ids"],
            voteAverage: double.parse(e["vote_average"].toString()),
            releaseDate: e["first_air_date"]
        );

        print(e["title"]);

        listPopulerTv.add(_data);
      });
    }
    else{
      throw Exception();
    }
  }

  Future<void> fetchMovieDetail(int id) async {
    final respone = await http.get("https://api.themoviedb.org/3/movie/$id?api_key=$_apiKey&language=en-US");

    if(respone.statusCode == 200){
      var json = jsonDecode(respone.body);

      MovieDetail _data = new MovieDetail(
        title: json["title"],
        genres: json["genres"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        runtime: json["runtime"],
        voteAverage: double.parse(json["vote_average"].toString())
      );

      movieDetail = _data;
    }
    else{
      throw Exception();
    }
  }

  Future<void> fetchTvDetail(int id) async {
    final respone = await http.get("https://api.themoviedb.org/3/tv/$id?api_key=$_apiKey&language=en-US");

    if(respone.statusCode == 200){
      var json = jsonDecode(respone.body);

      TvDetail _data = new TvDetail(
        firstAirDate: json["first_air_date"],
        genres: json["genres"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasons: json["seasons"],
        voteAverage: double.parse(json["vote_average"].toString()),
      );

      tvDetail = _data;
    }
    else{
      throw Exception();
    }
  }

  Future<void> fetchMovieCast(int id) async {
    final respone = await http.get("https://api.themoviedb.org/3/movie/$id/credits?api_key=$_apiKey");

    listMovieCast = List<MovieCast>();

    if(respone.statusCode == 200){
      var json = jsonDecode(respone.body);

      var cast = json["cast"];

      cast.forEach((e){
        var _data = MovieCast(
          castId: e["cast_id"],
          character: e["character"],
          name: e["name"],
          profilePath: e["profile_path"]
        );

        listMovieCast.add(_data);
      });

    }
    else{
      throw Exception();
    }
  }

  Future<void> fetchTvCast(int id) async {
    final respone = await http.get("https://api.themoviedb.org/3/tv/$id/credits?api_key=$_apiKey");

    listTvCast = List<MovieCast>();

    if(respone.statusCode == 200){
      var json = jsonDecode(respone.body);

      var cast = json["cast"];

      cast.forEach((e){
        var _data = MovieCast(
            castId: e["cast_id"],
            character: e["character"],
            name: e["name"],
            profilePath: e["profile_path"]
        );

        listTvCast.add(_data);
      });

    }
    else{
      throw Exception();
    }
  }

  Future<List<MovieHome>> fetchSearchMovie(String query) async {

    final respone = await http.get("https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&language=en-US&page=1&include_adult=false&query=$query");

    listSearchMovie = List<MovieHome>();

    if(respone.statusCode == 200){

      var json = jsonDecode(respone.body);
      var result = json["results"];

      result.forEach((e){

        if(e["poster_path"] != null){
          MovieHome _data = new MovieHome(
              id: e["id"],
              posterPath: e["poster_path"],
              backdropPath: e["backdrop_path"],
              title: e["title"],
              genreIds: e["genre_ids"],
              voteAverage: double.parse(e["vote_average"].toString()),
              releaseDate: e["release_date"]
          );

          listSearchMovie.add(_data);
        }
      });

      return listSearchMovie;
    }
    else{
      throw Exception();
    }
  }
}