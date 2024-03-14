import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class post_data extends StatefulWidget {
  const post_data({super.key});

  @override
  State<post_data> createState() => _post_dataState();
}

class _post_dataState extends State<post_data> {


  //controller

  TextEditingController _data =  TextEditingController();

  //Creating Firebase Database Node similar to table in SQL - It will store all the post data.

  final _database_request = FirebaseDatabase.instance.ref("Post");

  //Make sure you mention your database URL in firebase files in your project.

  //Showing Message

  message(dynamic data,Color _color)
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data.toString(),style: GoogleFonts.monda(),),backgroundColor: _color,));
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Operation",
          style: GoogleFonts.monda(fontWeight: FontWeight.w500, fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              maxLines: 5,
              cursorColor: Colors.black,
              controller: _data,
              decoration: InputDecoration(
                  hintText: "Write any thing",
                  hintStyle: GoogleFonts.monda(),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.black))
              ),
            ),
            InkWell(
              onTap: (){
                dynamic id = DateTime.now().millisecondsSinceEpoch.toString();
                print("Method Called");
                _database_request.child(id).set({
                  "id" : id,
                  "Data" : _data.text.toString(),
                }).then((result) => {
                  debugPrint("success"),
                  message("Success", Colors.green),
                }).onError((error, stackTrace) => {
                  debugPrint("error"),
                  message(error, Colors.red),
                });
              },
              child: Container(
                height: height * 0.055,
                width: width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                child:  Center(
                  child: Text(
                      "Post Data",
                      style: GoogleFonts.monda( fontSize: 22,
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
