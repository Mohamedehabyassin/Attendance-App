import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_grad_project/Authn/SignUpPage.dart';

class StudentData extends StatefulWidget {
  @override
  _StudentDataState createState() => _StudentDataState();
}

class _StudentDataState extends State<StudentData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Data"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: ()=>Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context)=>new SignUpPage()
          )
        ),
      ),
      body: new FutureBuilder<List>(
        future: _getData(),
        builder: (context,snapshot){
          if(snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
            ? new ItemList(list: snapshot.data,)
            : new Center(
              child: new CircularProgressIndicator(),
            );
          
        }


      ),
      
      
    );
  }
//  @override
//void initState() {
//  super.initState();
//  _getData();
//}

  Future<List> _getData() async{
    var url = 'https://airiest-halyards.000webhostapp.com/getData.php';
    http.Response response = await http.get(url);
    //var data = jsonDecode(response.body);
    //print(data.toString());
    return json.decode(response.body);

    
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list==null?0:list.length,
      itemBuilder: (context,i){
        return Container(
          padding: const EdgeInsets.all(5.0),
          child: Card(
                    child: new ListTile(
              title: new Text(list[i]['name'],
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)
              ),
              leading: new Text(list[i]['year'],
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)
              ),
              subtitle: new Text(list[i]['mail']),
              trailing: new Text(list[i]['mobile_no']),


            ),
          ),
        );
      },
    );
  }
}