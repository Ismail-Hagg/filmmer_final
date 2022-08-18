import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_cocontroller.dart';
import '../models/upload.dart';
import '../storage_local/local_database.dart';
import '../widgets/custom_text.dart';

class Test extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;


  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomText(text:'sqflite'), actions: [
        IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.find<AuthController>().signOut();
            })
      ]),
      body: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        return Column(
          children: [
            Container(
              color: Colors.orange,
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                  text: constraints.maxHeight.toString(),
                ),
                CustomText(
                  text: constraints.maxWidth.toString(),
                )
                ],
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.7,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  onError: (error, stackTrace) => provide('assets/images/placeholder.jpg',0),
                  image: provide('https://images.unsplash.com/photo-1660704978699-ed53dd160e2e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', 1),
                  fit: BoxFit.cover,
                ),
                
              ),
            )
          ],
        );
      }),
    );
  }

  // Button onPressed methods

  ImageProvider provide(String link,int count){
    if(count==1){
      return NetworkImage(link);
    }else{
      return AssetImage(link);
    }
  }

  void _insert(FirebaseSend model) async {
    // row to insert

    final id = await dbHelper.insert(model.toMapLocal(), DatabaseHelper.table);
    print('inserted row id: $id');
    print(model.toMapLocal());
  }

  void _query() async {
    var lst = [];
    final allRows = await dbHelper.queryAllRows(DatabaseHelper.table);
    // print('query all rows:');
    // for (var element in allRows) {
    //   print(element['genres']);
    // }
    if (allRows.isEmpty) {
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
