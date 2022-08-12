class TestModel{
  String? name;
  String? id;

  TestModel({ this.name,  this.id});

 factory TestModel.fromMap(Map<String, String> map){
  return TestModel(
      name: map['name'].toString() ,
       id: map['id'].toString() ,
    );
 }  

 Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age':id
    };
  }
}