import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatelessWidget {
  final int id;
  final String name;
  CategoryItem({this.id, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: 30,
        child: OutlineButton(
          borderSide: BorderSide(
            color: ColorData().blue,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Center(
            child: Text(name, style: GoogleFonts.roboto(
                fontSize: 12,
                color: Colors.white
            ),),
          ),
          onPressed: (){
            print(id);
          },
        ),
      ),
    );
  }
}
