import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disiney_app/datas/fetch_api.dart';
import 'package:disiney_app/models/movie_cast.dart';
import 'package:disiney_app/models/movie_detail.dart';
import 'package:disiney_app/pages/loading_page.dart';
import 'package:disiney_app/pages/login/login.dart';
import 'package:disiney_app/pages/movie/widgets/cast_side.dart';
import 'package:disiney_app/pages/movie/widgets/category_item.dart';
import 'package:disiney_app/pages/movie/widgets/crew_side.dart';
import 'package:disiney_app/pages/movie/widgets/overview_side.dart';
import 'package:disiney_app/pages/movie/widgets/person_item.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class Movie extends StatefulWidget {
  final int id;
  Movie({this.id});

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  ScrollController _scrollController;
  bool _lastStatus, _loading;
  double _height;
  FetchApi _fetchApi;
  MovieDetail _movieDetail;
  List<MovieCast> _listMovieCast;
  String _movieId;
  Color _bookmarkColor;
  var _bookmarkIcon;

  @override
  void initState() {
    _height = 350;
    _lastStatus = true;
    _loading = true;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _bookmarkIcon = Icons.bookmark_border;
    _bookmarkColor = Colors.white;
    _fetchApi = FetchApi();
    fetchApi();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void fetchApi() async {
    await _fetchApi.fetchMovieDetail(widget.id);
    await _fetchApi.fetchMovieCast(widget.id);

    Color _colorData;
    var _iconData;
    String _dataMovieId;

    if(FirebaseAuth.instance.currentUser != null){
      var user = FirebaseAuth.instance.currentUser;
      var data = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("movies").get();

      data.docs.forEach((element) {
        int id = element.get("movie_id");

        if(id == widget.id){
          _dataMovieId = element.id;
          _iconData = Icons.bookmark;
          _colorData = ColorData().blue;

          setState(() {
            _movieId = _dataMovieId;
            _bookmarkColor = _colorData;
            _bookmarkIcon = _iconData;
          });
        }
      });
    }

    setState(() {
      _movieDetail = _fetchApi.movieDetail;
      _listMovieCast = _fetchApi.listMovieCast;
      _loading = false;
    });
  }

  void bookmark() async {
    var user = FirebaseAuth.instance.currentUser;
    Color _colorData;
    var _iconData;

    //if user login
    if(user != null){
      //bookmarked
      if(_bookmarkColor == Colors.white){
        _colorData = ColorData().blue;
        _iconData = Icons.bookmark;

        await FirebaseFirestore.instance.collection("users")
            .doc(user.uid)
            .collection("movies")
            .add({"movie_id" : widget.id, "poster_path" : _movieDetail.posterPath, "title" : _movieDetail.title});

        Toast.show(
            "Add to Bookmark",
            context,
            duration: Toast.LENGTH_SHORT,
            gravity:  Toast.BOTTOM,
            backgroundColor: ColorData().blue,
            textColor: Colors.white
        );
      }

      //remove bookmark
      else{
        _colorData = Colors.white;
        _iconData = Icons.bookmark_border;

       await FirebaseFirestore.instance.collection("users")
           .doc(user.uid)
           .collection("movies")
           .doc(_movieId).delete();

        Toast.show(
            "remove from Bookmark",
            context,
            duration: Toast.LENGTH_SHORT,
            gravity:  Toast.BOTTOM,
            backgroundColor: ColorData().blue,
            textColor: Colors.white
        );
      }

      setState(() {
        _bookmarkColor = _colorData;
        _bookmarkIcon = _iconData;
      });
    }

    //user didnt login
    else{
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Login()
      ));
    }
  }

  void _scrollListener() {
    if (_isShrink != _lastStatus) {
      setState(() {
        _lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (_height - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _loading ? LoadingPage() :

      CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: Visibility(
              visible: _isShrink ? true : false,
              child: Text(_movieDetail.title,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    color: Colors.white
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(_bookmarkIcon, color: _bookmarkColor,),
                onPressed: (){
                  bookmark();
                },
              )
            ],
            centerTitle: true,
            expandedHeight: 350,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Visibility(
                visible: _isShrink ? false : true,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(_movieDetail.title, style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: ColorData().blue
                  ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ),
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 0),
              collapseMode: CollapseMode.parallax,
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("https://image.tmdb.org/t/p/original/${_movieDetail.posterPath}")
                  )
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black])
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //info 1
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        //year
                        Text(_movieDetail.releaseDate.substring(0,4), style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text("|", style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),),
                        ),

                        //umur
                        Text("PG-14", style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),),

                        //durasi
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text("|", style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),),
                        ),

                        //rating
                        Text("2h 30m", style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text("|", style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),),
                        ),

                        Row(
                          children: [
                            Icon(Icons.star,
                              size: 18,
                              color: Colors.yellow,),

                            SizedBox(width: 5,),

                            Text("${_movieDetail.voteAverage}", style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),)
                          ],
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 15,),

                  //category
                  Container(
                    height: 30,
                    child: Center(
                      child: ListView.builder(
                          itemCount: _movieDetail.genres.length > 3 ? 3 : _movieDetail.genres.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => CategoryItem(
                            id: _movieDetail.genres[index]["id"],
                            name: _movieDetail.genres[index]["name"],
                          )
                      ),
                    ),
                  ),

                  SizedBox(height: 35,),

                  //overview
                  OverviewSide(
                    overview: _movieDetail.overview,
                  ),

                  SizedBox(height: 35,),

                  //cast
                  CastSide(
                    listMovieCast: _listMovieCast,
                  ),

                  SizedBox(height: 35,),

                  //crew
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}
