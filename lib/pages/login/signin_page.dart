import 'package:disiney_app/pages/home/home_page.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _pass;

  void signin() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _pass);

        Toast.show(
            "Berhasil Login",
            context,
            duration: Toast.LENGTH_SHORT,
            gravity:  Toast.BOTTOM,
            backgroundColor: ColorData().blue,
            textColor: Colors.white
        );

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(
                builder: (context) => HomePage()),
                (route) => false);
      }
      on FirebaseAuthException catch(e){
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        }
        else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [

          Image.network(
            "https://images.unsplash.com/photo-1526674215851-1adc0e4dbd5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=732&q=80",
            fit: BoxFit.cover,
            height: double.infinity,
          ),

          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black54,
          ),

          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
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

                    SizedBox(height: 80,),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [

                          //email
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: GoogleFonts.roboto(
                                color: Colors.white
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                            ),
                            style: GoogleFonts.roboto(color: ColorData().blue),
                            onSaved: (value) => _email = value,
                            validator: (value){
                              if(value.isEmpty){
                                return "Maaf Email anda kosong";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20,),

                          //Pass
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: GoogleFonts.roboto(
                                  color: Colors.white
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                            ),
                            style: GoogleFonts.roboto(color: ColorData().blue),
                            obscureText: true,
                            onSaved: (value) => _pass = value,
                            validator: (value){
                              if(value.isEmpty){
                                return "Maaf Password anda kosong";
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 60,),

                    SizedBox(
                      height: 35,
                      width: 160,
                      child: RaisedButton(
                        color: ColorData().blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Text("Sign In", style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16
                        ),),
                        onPressed: (){
                          signin();
                        },
                      ),
                    )
                  ],
                )
              ),
            ),
          )

        ],
      ),
    );
  }
}
