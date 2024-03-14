import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class delete_data extends StatefulWidget {
  const delete_data({super.key});

  @override
  State<delete_data> createState() => _delete_dataState();
}

class _delete_dataState extends State<delete_data> {


  //firebase reference

  final _ref = FirebaseDatabase.instance.ref("Post");

  //variables

  dynamic id;



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Data",
        style: GoogleFonts.monda(

        ),),
        centerTitle: true,
      ),
      body:  Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(query: _ref, itemBuilder: (context,snapshot,index,animation){
              id = snapshot.child("id").value.toString();
              return ListTile(
                title: Text("${snapshot.child("Data").value.toString()}"),
                trailing: InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (context){
                        return Dialog(
                          child: Container(
                            height: height*0.3,
                            width: width*0.7,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(14)
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Delete Data",style: GoogleFonts.monda(
                                      color: Colors.white,
                                      fontSize: 20
                                  ),),
                                  Container(
                                    height: height*0.044,
                                    width: width*0.5,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Center(child: InkWell(
                                      onTap: (){
                                        //connect with FIREBASE
                                        _ref.child(snapshot.child('id').value.toString()).remove().then((value) =>
                                        {
                                          print("Successfully deleted"),
                                          Navigator.pop(context),
                                        }).onError((error, stackTrace) => {
                                          print("Un-Successfully deleted"),
                                        });
                                      },
                                      child: Text("Delete It",style: GoogleFonts.monda(
                                          color: Colors.black,
                                          fontSize: 15
                                      ),),
                                    ),),
                                  ),
                                  Container(
                                    height: height*0.044,
                                    width: width*0.5,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Center(child: InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text("Keep It",style: GoogleFonts.monda(
                                          color: Colors.black,
                                          fontSize: 15
                                      ),),
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },
                    child: Icon(Icons.delete))
              );
            })
          )
        ],
      ),
    );
  }
}
