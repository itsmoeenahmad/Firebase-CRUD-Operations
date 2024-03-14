import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class update_data extends StatefulWidget {
  const update_data({super.key});

  @override
  State<update_data> createState() => _update_dataState();
}

class _update_dataState extends State<update_data> {

  //Controller

  final _search = TextEditingController();
  final _update = TextEditingController();

  //firebase database reference

  final _ref = FirebaseDatabase.instance.ref("Post");

  //data is

  dynamic data,id;

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Data",style: GoogleFonts.monda(
            fontSize: 22
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
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black)),
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
                      data = data_list[index]["Data"];
                      id = data_list[index]["id"];
                      if(_search.text.isEmpty)
                      {
                        //Here I will update the data.
                        return ListTile(
                          title: Text("${data_list[index]["id"]}"),
                          subtitle: Text("${data_list[index]["Data"]}"),
                          trailing: InkWell(
                              onTap: (){
                                showDialog(context: context, builder: (context){
                                  _update.text = data_list[index]["Data"].toString();
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
                                            Text("Update Data",style: GoogleFonts.monda(
                                              color: Colors.white,
                                              fontSize: 20
                                            ),),
                                            TextFormField(
                                              controller: _update,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                hintText: "Enter data",
                                                hintStyle: TextStyle(color: Colors.white,fontSize: 14),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                  borderSide: BorderSide(color: Colors.white,)
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                    borderSide: BorderSide(color: Colors.white,)
                                                )
                                              ),
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
                                                  //connect with FIREBASE
                                                  _ref.child(data_list[index]["id"].toString()).update(
                                                      {
                                                      "Data" : _update.text.toString(),
                                                      }
                                                  ).then((value) => {
                                                    print("Updated Successfully"),
                                                    Navigator.pop(context),
                                                  }).onError((error, stackTrace) =>
                                                  {
                                                    print("Updated Un-Successfully"),
                                                  });
                                                },
                                                child: Text("Update Data",style: GoogleFonts.monda(
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
                              child: Icon(Icons.edit)),
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
