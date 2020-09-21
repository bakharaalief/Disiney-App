import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disiney_app/pages/loading_page.dart';
import 'package:disiney_app/pages/profile/widgets/movie_book_side.dart';
import 'package:disiney_app/pages/profile/widgets/profile_info_side.dart';
import 'package:disiney_app/pages/profile/widgets/tv_book_side.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _username, _email;
  String _userid;
  bool _loading;

  @override
  void initState() {
    fetchFirebase();
    _loading = true;
    super.initState();
  }

  void fetchFirebase() async {
    var userId = FirebaseAuth.instance.currentUser.uid;
    var userProfile = await FirebaseFirestore.instance.collection("users").doc(userId).get();

    setState(() {
      _username = userProfile.get("username");
      _email = userProfile.get("email");
      _userid = userId;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: _loading ? LoadingPage() :

      SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 10,),

            //profile info
            ProfileInfoSide(
              username: _username,
              email: _email,
              context: context,
            ),

            SizedBox(height: 40,),

            //movie book
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").doc(_userid).collection("movies").snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return MovieBookSide(
                    listData: snapshot.data,
                  );
                }
                return Container();
              },
            ),

            SizedBox(height: 20,),

            //tv book
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").doc(_userid).collection("tvs").snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return TvBookSide(
                    listData: snapshot.data,
                  );
                }
                return Container();
              },
            )

          ],
        ),
      )
    );
  }
}

