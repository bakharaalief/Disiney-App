import 'package:carousel_slider/carousel_slider.dart';
import 'package:disiney_app/datas/fetch_api.dart';
import 'package:disiney_app/models/movie_home.dart';
import 'package:disiney_app/pages/home/widgets/movie_header.dart';
import 'package:disiney_app/pages/home/widgets/populer_movie._side.dart';
import 'package:disiney_app/pages/home/widgets/populer_tv._side.dart';
import 'package:disiney_app/pages/loading_page.dart';
import 'package:disiney_app/pages/login/login.dart';
import 'package:disiney_app/pages/movie/movie.dart';
import 'package:disiney_app/pages/profile/profile.dart';
import 'package:disiney_app/pages/tv/tv.dart';
import 'file:///C:/Users/Bakhara/flutter_projects/disiney_app/lib/pages/home/searchDelegate/custom_search.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchApi _fetchApi;
  bool _loading;
  List<MovieHome> _listTranding;
  List<MovieHome> _listPopulerMovie;
  List<MovieHome> _listPopulerTv;
  Color _profileColor;

  @override
  void initState() {
    _fetchApi = FetchApi();
    _loading = true;
    _profileColor = Colors.white;
    getData();
    super.initState();
  }

  void getData() async{
    await _fetchApi.fetchTrending();
    await _fetchApi.fetchMovie();
    await _fetchApi.fetchTv();

    await Firebase.initializeApp();

    setState(() {
      _listTranding =_fetchApi.listTrending;
      _listPopulerMovie = _fetchApi.listPopulerMovie;
      _listPopulerTv = _fetchApi.listPopulerTv;
      _profileColor = FirebaseAuth.instance.currentUser == null ? Colors.white : ColorData().blue;
      _loading = false;
    });
  }

  void profileButton(){

    if(FirebaseAuth.instance.currentUser != null){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Profile()
      ));
    }

    else{
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Login()
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Disiney", style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white
            ),),
            Text("+", style: GoogleFonts.roboto(
                color: Colors.white
            ),)
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.person, color: _profileColor,),
          onPressed: (){
            profileButton();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            onPressed: (){
              showSearch(
                  context: context,
                  delegate: CustomSearch());
            },
          ),
        ],
      ),
      body: _loading ?

      LoadingPage() :

      SingleChildScrollView(
        child: Column(
          children: [

            //carousel image
            CarouselSlider.builder(
                itemCount: _listTranding.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    //type movie
                    if(_listTranding[index].mediaType == "movie"){
                      Navigator.push(context, MaterialPageRoute(
                          builder : (context) => Movie(id: _listTranding[index].id,)
                      ));
                    }

                    //else
                    else{
                      Navigator.push(context, MaterialPageRoute(
                          builder : (context) => Tv(id: _listTranding[index].id,)
                      ));
                    }
                  },
                  child: MovieHeader(
                    title: _listTranding[index].title,
                    backdropPath: _listTranding[index].backdropPath,
                  ),
                ),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true
                )
            ),

            SizedBox(height: 40,),

            //populer movie
            PopulerMovieSide(
              listMovieHome: _listPopulerMovie,
            ),

            SizedBox(height: 40,),

            PopulerTvSide(
              listPopulerTv: _listPopulerTv,
            )

          ],
        ),
      )
    );
  }
}


