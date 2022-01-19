// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/authModel.dart';
import 'package:flutter_chat_app/service/database.dart';
import 'package:flutter_chat_app/ui/addWeight.dart';
import 'package:flutter_chat_app/ui/baseView.dart';
import 'package:flutter_chat_app/ui/editWeight.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthModel>(
      builder: (context, model, __) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddWeight()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Weight Tracker"),
          actions: [
            IconButton(
                onPressed: () {
                  model.logOut();
                },
                icon: Icon(Icons.logout_sharp))
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<QuerySnapshot>(
            stream: Database.readItems(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              } else if (snapshot.hasData || snapshot.data != null) {
                return ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 16.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var noteInfo = snapshot.data.docs[index].data();
                    String docID = snapshot.data.docs[index].id;
                    String title = noteInfo['Weight'];

                    return Ink(
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditWeight(
                              currentTitle: title,
                              documentId: docID,
                            ),
                          ),
                        ),
                        title: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          'description',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                );
              }

              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            },
          ),
        ),
        // body: RaisedButton(
        //   color: Colors.cyanAccent,
        //   child: Text("Log Out"),
        //   onPressed: () {
        //     // model.logOut();
        //   },
        // ),
      ),
    );
  }
}
