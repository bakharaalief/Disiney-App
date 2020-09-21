import 'package:disiney_app/theme/color_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.tv, color: ColorData().blue, size: 80,),

            SizedBox(height: 10,),

            Text("Loadinggg..", style: GoogleFonts.roboto(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: Colors.white
            ),)
          ],
        )
      ),
    );
  }
}
