import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disiney_app/pages/home/home_page.dart';
import 'package:disiney_app/theme/color_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _pass, _username;

  void signup() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _pass)
            .then((value){

              FirebaseFirestore.instance.collection("users").doc(value.user.uid).set({
                "email" : value.user.email,
                "username" : _username
              });
            });

        Toast.show(
            "Akun Berhasil Dibuat",
            context,
            duration: Toast.LENGTH_SHORT,
            gravity:  Toast.BOTTOM,
            backgroundColor: ColorData().blue,
            textColor: Colors.white
        );

        Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomePage()
        ));
      }
      on FirebaseAuthException catch (e){
        String error;

        if(e.code == 'email-already-in-use'){
          error = 'Email telah digunakan.';
        }

        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Sing Up"),
                content: Text(error),
              );
            }
        );
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

                      SizedBox(height: 80,),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [

                            //username
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: GoogleFonts.roboto(
                                    color: Colors.white
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.white
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.white
                                    )
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.red
                                    )
                                ),
                              ),
                              style: GoogleFonts.roboto(
                                  color: ColorData().blue
                              ),
                              onSaved: (value) => _username = value,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Maaf Username anda kosong";
                                }
                                else if(value.length < 5){
                                  return "Maaf username kurang dari 5";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20,),

                            //email
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle: GoogleFonts.roboto(
                                      color: Colors.white
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )
                                  ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.red
                                    )
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              style: GoogleFonts.roboto(
                                  color: ColorData().blue
                              ),
                              onSaved: (value) => _email = value,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Maaf Email anda kosong";
                                }
                                else if(value.length < 5){
                                  return "Maaf Email kurang dari 5";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20,),

                            //password
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: GoogleFonts.roboto(
                                    color: Colors.white
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.white
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.white
                                    )
                                ),

                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.red
                                  )
                              ),
                              ),
                              style: GoogleFonts.roboto(
                                  color: ColorData().blue
                              ),
                              onSaved: (value) => _pass = value,
                              obscureText: true,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Maaf Password anda kosong";
                                }
                                else if(value.length < 5){
                                  return "Maaf Password kurang dari 5";
                                }
                                return null;
                              },
                            ),
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
                          child: Text("Sign Up", style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16
                          ),),
                          onPressed: (){
                            signup();
                          },
                        ),
                      )
                    ],
                  )
              ),
            ),
          ),
        ],
      )
    );
  }
}
