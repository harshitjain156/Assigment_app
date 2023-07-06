import 'dart:convert';
import 'package:first_app/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleObject {
  final String title;
  final String article;

  ArticleObject({required this.title, required this.article});

  Map<String, dynamic> toMap() {
    return {'title': title, 'article': article};
  }

  factory ArticleObject.fromJson(Map<String, dynamic> json) {
    return ArticleObject(title: json['title'], article: json['article']);
  }
}


class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final _formKey = GlobalKey<FormState>();
  var name;

  var title = TextEditingController();
  var body = TextEditingController();
  List<ArticleObject> _myObjects = [];

  @override
  void initState() {
    super.initState();
    getValue();
    _loadDataFromPrefs();
  }

  void _loadDataFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? myObjectsJson = prefs.getString('myObjects');
    if (myObjectsJson != null) {
      Iterable decoded = json.decode(myObjectsJson);
      List<ArticleObject> objects =
          decoded.map((e) => ArticleObject.fromJson(e)).toList();
      setState(() {
        _myObjects = objects;
      });
    }
  }
  void getValue() async {
    var prefs=await SharedPreferences.getInstance();
    name=prefs.getString("name");
    // print(display);

  }
  void _saveDataToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myObjectsJson =
        json.encode(_myObjects.map((e) => e.toMap()).toList());
    await prefs.setString('myObjects', myObjectsJson);
  }

  void _addObject() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ArticleObject newObject = ArticleObject(
          title: title.text.toString(), article: body.text.toString());
      setState(() {
        _myObjects.add(newObject);
      });
      _saveDataToPrefs();
      title.clear();
      body.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Articles'),
        ),
        body:

        Container(
          child:
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(
          //         'Name: $name',
          //         style: TextStyle(fontSize: 20),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(
          //         'Age: age',
          //         style: TextStyle(fontSize: 20),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(
          //         'Gender: gender',
          //         style: TextStyle(fontSize: 20),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(
          //         'Country: country',
          //         style: TextStyle(fontSize: 20),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(
          //         'Hobbies:',
          //         style: TextStyle(fontSize: 20),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           // for (String hobby in hobbies)
          //             Text(
          //               '- hobby',
          //               style: TextStyle(fontSize: 16),
          //             ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),

          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Card(
                    margin: const EdgeInsets.all(20.0),
                    elevation: 3.0,
                    child:Container(
                      margin: const EdgeInsets.all(20.0) ,
                      child:
                      Column(

                        children: [
                          TextFormField(
                            controller: title,
                            decoration: InputDecoration(label: Text("Title")),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Title';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: body,
                            decoration: InputDecoration(label: Text("Body")),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter data';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),
                          ElevatedButton(onPressed:  _addObject, child: Text("Add"))
                        ],
                      )),
                    )
                  ),
              Expanded(
                child: ListView.builder(
                  itemCount: _myObjects.length,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      Card(
                      elevation: 4,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _myObjects[index].title.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 10),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: name,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '  |  ',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '5 min read',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _myObjects[index].article.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Text('Read more'),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.bookmark_border),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            // "_addObject"
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          tooltip: 'Add Object',
          child: Icon(Icons.person),
        ),
      ),
    );
  }
}
