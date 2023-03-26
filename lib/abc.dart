import 'dart:convert';
import 'package:first_app/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyObject {
  final String name;
  var age;

  MyObject({required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {'name': name, 'age': age};
  }

  factory MyObject.fromJson(Map<String, dynamic> json) {
    return MyObject(name: json['name'], age: json['age']);
  }
}

class MyApp5 extends StatelessWidget {
  const MyApp5({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyApp3(),
    );
  }
}

class MyApp3 extends StatefulWidget {
  @override
  _MyApp3State createState() => _MyApp3State();
}

class _MyApp3State extends State<MyApp3> {
  final _formKey = GlobalKey<FormState>();
  var name;

  var title = TextEditingController();
  var body = TextEditingController();
  List<MyObject> _myObjects = [];

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
      List<MyObject> objects =
          decoded.map((e) => MyObject.fromJson(e)).toList();
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

      MyObject newObject = MyObject(
          name: title.text.toString(), age: body.text.toString());
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
                                return 'Please enter your Country';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: body,
                            decoration: InputDecoration(label: Text("Body")),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Country';
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
                                  _myObjects[index].name.toString(),
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
                                  _myObjects[index].age.toString(),
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
                      // Card(
                      //   margin: const EdgeInsets.symmetric(
                      //       vertical: 5.0, horizontal: 30.0),
                      //   child: Container(
                      //     margin: const EdgeInsets.symmetric(
                      //         vertical: 10.0, horizontal: 30.0),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       children: [
                      //         Title(
                      //             color: Colors.black,
                      //             child:
                      //                 Text(_myObjects[index].name, textAlign: TextAlign.left,textScaleFactor: 1.2)),
                      //         Text(_myObjects[index].age,textAlign: TextAlign.left,)
                      //       ],
                      //     ),
                      //   ));
                    //   ListTile(
                    //   title: Text(_myObjects[index].name),
                    //   subtitle: Text('Age: ${_myObjects[index].age}'),
                    // );
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
