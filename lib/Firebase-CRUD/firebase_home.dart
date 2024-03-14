import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CRUD-Operation/delete_data.dart';
import 'CRUD-Operation/fetch_post_data.dart';
import 'CRUD-Operation/fetch_using_stream_builder.dart';
import 'CRUD-Operation/post_data.dart';
import 'CRUD-Operation/update_data..dart';

class firebase_home extends StatefulWidget {
  const firebase_home({super.key});

  @override
  State<firebase_home> createState() => _firebase_homeState();
}

class _firebase_homeState extends State<firebase_home> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Firebase Home Screen",
          style: GoogleFonts.monda(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const post_data()));
              },
              child: Container(
                height: height * 0.055,
                width: width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                child:  Center(
                  child: Text(
                      "Post Data - Screen",
                      style: GoogleFonts.monda( fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal)
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const fetched_post_data()));
              },
              child: Container(
                height: height * 0.055,
                width: width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                child:  Center(
                  child: Text(
                      "Fetching Data From Post Data List - Screen",
                      style: GoogleFonts.monda( fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal)
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const fetch_using_stream_builder()));
              },
              child: Container(
                height: height * 0.055,
                width: width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                child:  Center(
                  child: Text(
                      "Fetching Data Using Stream Builder - Screen",
                      style: GoogleFonts.monda( fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal)
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const update_data()));
              },
              child: Container(
                height: height * 0.055,
                width: width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                child:  Center(
                  child: Text(
                      "Update Data - Screen",
                      style: GoogleFonts.monda( fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal)
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const delete_data()));
              },
              child: Container(
                height: height * 0.055,
                width: width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                child:  Center(
                  child: Text(
                      "Delete Data - Screen",
                      style: GoogleFonts.monda( fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
