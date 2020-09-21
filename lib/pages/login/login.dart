import 'package:disiney_app/pages/login/signin_page.dart';
import 'package:disiney_app/pages/login/signup_page.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  void signupPage(){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => SignupPage()
    ));
  }
  
  void signinPage(){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => SigninPage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("https://images.unsplash.com/photo-1526674215851-1adc0e4dbd5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=732&q=80")
            )
        ),
        child: Container(
          color: Colors.black54,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Disiney+", style: GoogleFonts.roboto(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: Colors.white
              ),),

              SizedBox(height: 5,),

              Text("Cari Film Disiney aja", style: GoogleFonts.roboto(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: ColorData().blue
              ),),

              SizedBox(height: 280,),

              SizedBox(
                height: 35,
                width: 160,
                child: RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Text("Sign In", style: GoogleFonts.roboto(
                    color: ColorData().blue,
                    fontWeight: FontWeight.w900,
                    fontSize: 16
                  ),),
                  onPressed: (){
                    signinPage();
                  },
                ),
              ),

              SizedBox(height: 10,),

              SizedBox(
                height: 35,
                width: 160,
                child: RaisedButton(
                  color: ColorData().blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Text("Sign Up", style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16
                  ),),
                  onPressed: (){
                    signupPage();
                  },
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
