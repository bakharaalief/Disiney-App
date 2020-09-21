import 'package:disiney_app/pages/home/home_page.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfoSide extends StatelessWidget {
  final String username, email;
  final BuildContext context;

  ProfileInfoSide({this.username, this.email, this.context});

  void signout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("https://images.unsplash.com/photo-1530712232512-e07308778fbb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80")
              )
            ),
          ),

          SizedBox(width: 10,),

          Container(
            width: 200,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(username, style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: ColorData().blue
                ),),

                SizedBox(height: 10,),

                Text(email, style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.white
                ),),

                RaisedButton(
                  onPressed: (){
                    signout();
                  },
                  child: Text("Sign Out"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
