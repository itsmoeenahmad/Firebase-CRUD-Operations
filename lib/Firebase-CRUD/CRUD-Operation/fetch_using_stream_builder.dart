import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class fetch_using_stream_builder extends StatefulWidget {
  const fetch_using_stream_builder({super.key});

  @override
  State<fetch_using_stream_builder> createState() => _fetch_using_stream_builderState();
}

class _fetch_using_stream_builderState extends State<fetch_using_stream_builder> {

  //Controller

  final _search = TextEditingController();

  //firebase database reference

  final _ref = FirebaseDatabase.instance.ref("Post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data Using Stream Builder",style: GoogleFonts.monda(
          fontSize: 18
        ),),
        centerTitle: true,
      ),
      body:  Column(
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
            child: StreamBuilder(stream: _ref.onValue, builder: (context,snapshot) {

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
              else {
                Map<dynamic, dynamic> data_map = snapshot.
                data!.snapshot.value as dynamic;
                List<dynamic> data_list = data_map.values.toList();


                return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context, index) {
                      final title = data_list[index]["Data"];

                      if(_search.text.isEmpty)
                        {
                          return ListTile(
                            title: Text("Id is ${data_list[index]["id"]}"),
                            subtitle: Text("Data is ${data_list[index]["Data"]}"),
                          );
                        }
                      else if(title.toString().toLowerCase().contains(_search.text.toLowerCase().toString()))
                        {
                          return ListTile(
                            title: Text("Id is ${data_list[index]["id"]}"),
                            subtitle: Text("Data is ${data_list[index]["Data"]}"),
                          );
                        }
                      else
                        {
                          return Text("");
                        }
                    });
              }
            }
            ),
          )
        ],
      ),
    );
  }
}
