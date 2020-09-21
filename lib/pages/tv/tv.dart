import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disiney_app/datas/fetch_api.dart';
import 'package:disiney_app/models/movie_cast.dart';
import 'package:disiney_app/models/tv_detail.dart';
import 'package:disiney_app/pages/loading_page.dart';
import 'package:disiney_app/pages/login/login.dart';
import 'package:disiney_app/pages/tv/widgets/cast_side.dart';
import 'package:disiney_app/pages/tv/widgets/category_item.dart';
import 'package:disiney_app/pages/tv/widgets/overview_side.dart';
import 'package:disiney_app/pages/tv/widgets/seasons_side.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class Tv extends StatefulWidget {
  final int id;
  Tv({this.id});

  @override
  _TvState createState() => _TvState();
}

class _TvState extends State<Tv> {
  ScrollController _scrollController;
  bool _lastStatus, _loading;
  double _height;
  FetchApi _fetchApi;
  TvDetail _tvDetail;
  List<MovieCast> _listTvCast;
  Color _bookmarkColor;
  var _bookmarkIcon;
  String _movieId;

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
    await _fetchApi.fetchTvDetail(widget.id);
    await _fetchApi.fetchTvCast(widget.id);

    Color _colorData;
    var _iconData;
    String _dataMovieId;

    if(FirebaseAuth.instance.currentUser != null){
      var user = FirebaseAuth.instance.currentUser;
      var data = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("tvs").get();

      data.docs.forEach((element) {
        int id = element.get("tv_id");

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
      _tvDetail = _fetchApi.tvDetail;
      _listTvCast = _fetchApi.listTvCast;
      _loading = false;
    });
  }

  void bookmark() async {
    var user = FirebaseAuth.instance.currentUser;
    Color _colorData;
    var _iconData;

    if(user != null){
      //bookmarked
      if(_bookmarkColor == Colors.white){
        _colorData = ColorData().blue;
        _iconData = Icons.bookmark;

        await FirebaseFirestore.instance.collection("users")
            .doc(user.uid)
            .collection("tvs")
            .add({"tv_id" : widget.id, "poster_path" : _tvDetail.posterPath, "name" : _tvDetail.name});

        Toast.show(
            "Add to Bookmark",
            context,
            duration: Toast.LENGTH_SHORT,
            gravity:  Toast.BOTTOM,
            backgroundColor: ColorData().blue,
            textColor: Colors.white
        );
      }

      //remove
      else{
        _colorData = Colors.white;
        _iconData = Icons.bookmark_border;

        await FirebaseFirestore.instance.collection("users")
            .doc(user.uid)
            .collection("tvs")
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
              child: Text(_tvDetail.name,
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
                child: Text(_tvDetail.name, style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: ColorData().blue
                ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 0),
              collapseMode: CollapseMode.parallax,
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("https://image.tmdb.org/t/p/original/${_tvDetail.posterPath}")
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
                        Text(_tvDetail.firstAirDate.substring(0,4), style: GoogleFonts.roboto(
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

                            Text("${_tvDetail.voteAverage}", style: GoogleFonts.roboto(
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
                          itemCount: _tvDetail.genres.length > 3 ? 3 : _tvDetail.genres.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => CategoryItem(
                            id: _tvDetail.genres[index]["id"],
                            name: _tvDetail.genres[index]["name"],
                          )
                      ),
                    ),
                  ),

                  SizedBox(height: 35,),

                  //overview
                  OverviewSide(
                    overview: _tvDetail.overview,
                  ),

                  SizedBox(height: 35,),

                  //cast
                  CastSide(
                    listMovieCast: _listTvCast,
                  ),

                  SizedBox(height: 35,),

                  //sesons
                  SeasonsSide(
                    listSeason: _tvDetail.seasons,
                  )

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
