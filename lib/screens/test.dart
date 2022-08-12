import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_cocontroller.dart';
import '../models/test_model.dart';
import '../models/upload.dart';
import '../storage_local/local_database.dart';
import '../widgets/custom_text.dart';

class Test extends StatelessWidget {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed:(){
              Get.find<AuthController>().signOut();
            }
          )
        ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text(
                'insert',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => _insert(FirebaseSend(
                  genres: ['one','teo','things'],
                  id: 'kkk',
                  isShow: true,
                  name: 'name',
                  overView: 'overView',
                  posterPath: 'posterPath',
                  releaseDate: 'releaseDate',
                  time: 'time',
                  voteAverage: 5.5)),
            ),
            ElevatedButton(
              child: Text(
                'query',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _query,
            ),
            ElevatedButton(
              child: Text(
                'update',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text(
                'delete',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _delete,
            ),
            Expanded(
                child: FutureBuilder(
                    future: dbHelper.queryAllRows(DatabaseHelper.table,),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return CustomText(
                              text: snapshot.data![index]['title'].toString(),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    }))
          ],
        ),
      ),
    );
  }

  // Button onPressed methods

  void _insert(FirebaseSend model) async {
    // row to insert
   

    final id = await dbHelper.insert(model.toMapLocal(),DatabaseHelper.table);
    print('inserted row id: $id');
    print(model.toMapLocal());
    
  }

  void _query() async {
    var lst=[];
    final allRows = await dbHelper.queryAllRows(DatabaseHelper.table);
    // print('query all rows:');
    // for (var element in allRows) {
    //   print(element['genres']);
    // }
    if(allRows.isEmpty){
      print('no results');
    }
    for (var i = 0; i < allRows.length; i++) {
      print(allRows[i]['name']);
      
    }
  }

  // void _update() async {
  //   // row to update
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnId   : 2,
  //     DatabaseHelper.columnName : 'j cile',
  //     DatabaseHelper.columnAge  : 32
  //   };
  //   final rowsAffected = await dbHelper.update(row);
  //   print('updated $rowsAffected row(s)');
  // }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    //final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.deleteAll(DatabaseHelper.showTable);
    //print('deleted $rowsDeleted row(s): row $id');
  }
}
