import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class fetched_post_data extends StatefulWidget {
  const fetched_post_data({super.key});

  @override
  State<fetched_post_data> createState() => _fetched_post_dataState();
}

class _fetched_post_dataState extends State<fetched_post_data> {
  
  //controller
  final _search = TextEditingController();

  //Firebase database reference - Instance

  final _ref = FirebaseDatabase.instance.ref("Post");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Firebase Home Screen",
          style: GoogleFonts.monda(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                controller: _search,
                onChanged: (String change_value)
                {
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                    hintText: "Search",
                    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                    hintStyle: GoogleFonts.monda(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black))
                ),
              ),
            ),
            
            Expanded(
              child: FirebaseAnimatedList(query: _ref, itemBuilder: (context,snapshot,animation,index){
                
                final data = snapshot.child("Data").value.toString();
                 if(_search.text.isEmpty)
                   {
                     return ListTile(
                       leading: Icon(Icons.data_saver_off),
                       title: Text(snapshot.child("Data").value.toString()),
                       subtitle: Text(snapshot.child("id").value.toString()),
                     );
                   }
                else if(data.toString().toLowerCase().contains(_search.text.toLowerCase().toString()))
                  {
                    return ListTile(
                      leading: Icon(Icons.data_saver_off),
                      title: Text(snapshot.child("Data").value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    );
                  }
                else
                  {
                    return Text("");
                  }
                
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (){
          
        },
        child: Icon(Icons.get_app,color: Colors.white,),
      ),
    );
  }
}
