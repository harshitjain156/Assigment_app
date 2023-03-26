import 'dart:convert';

import 'package:first_app/abc.dart';
import 'package:first_app/artice_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp2 extends StatelessWidget {
//   const MyApp2({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//       title: 'Login',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage2(title: 'first app',),
//     );
//   }
// }

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage2> createState() => _MyHomePage2State();

}

class _MyHomePage2State extends State<MyHomePage2> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
  }
  var name=TextEditingController();
  var age=TextEditingController();
  var gender=TextEditingController();
  var country=TextEditingController();
  var hobbies=TextEditingController();
  var number=TextEditingController();
  int _counter = 0;
  var display;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,

          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child:Card(
            margin: const EdgeInsets.all(20.0),
            shadowColor: Color.fromARGB(0, 0, 0, 200),
            borderOnForeground: true,
            elevation: 10,
            color: Colors.transparent,
            child:Container(
              margin: const EdgeInsets.all(20.0),
              child:Column(
                children: [
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                        label: Text("Name")
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: age,
                    decoration: InputDecoration(
                        label: Text("Age")
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Age';
                      }
                      return null;
                    },

                  ),
                  TextFormField(
                    controller: gender,
                    decoration: InputDecoration(
                        label: Text("Gender")
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Gender';
                      }
                      return null;
                    },

                  ),
                  TextFormField(
                    controller: hobbies,
                    decoration: InputDecoration(
                        label: Text("Hobbies")
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Hobbies';
                      }
                      return null;
                    },

                  ),
                  TextFormField(
                    controller: country,
                    decoration: InputDecoration(
                        label: Text("Country")
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Country';
                      }
                      return null;
                    },

                  ),
                  TextFormField(
                    controller: number,
                    decoration: InputDecoration(
                        label: Text("Mobile No.")
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your number';
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: ()async{
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          var prefs=await SharedPreferences.getInstance();
                          prefs.setString("name", name.text.toString());
                          prefs.setString("age", age.text.toString());
                          prefs.setString("number", number.text.toString());
                          prefs.setString("country", country.text.toString());
                          prefs.setString("gender", gender.text.toString());
                          prefs.setString("hobby", hobbies.text.toString());
                          prefs.setBool('log', true);
                          print(_formKey.currentState!.validate());
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp3()),);
                        }
                        setState(() {
                          getValue();
                        });

                      }, child:Text("Login")),
                    ],
                  )



                ],
              )
            )

          )

        )
    );
  }

  void getValue() async {
    var prefs=await SharedPreferences.getInstance();
    display=prefs.getString("name");
    print(display);

  }

  void validate() {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();
    //   var prefs=await SharedPreferences.getInstance();
    //   prefs.setString("name", name.text.toString());
    //   prefs.setString("age", age.text.toString());
    //   prefs.setString("number", number.text.toString());
    //   prefs.setString("country", country.text.toString());
    //   prefs.setString("gender", gender.text.toString());
    //   prefs.setBool('log', true);
    // }
  }
}



//
// class _MyHomePage extends StatefulWidget{
//
//   @override
//   State<StatefulWidget> createState() {
//     return _MyHomeState();
//   }
//
// }
// class _MyHomeState extends State<_MyHomePage> {
//   final _formKey = GlobalKey<FormState>();
//
//   String _name = 'Harsh';
//   int _age = 0;
//   String _gender = '';
//   String _country = '';
//   String _hobbies = '';
//   @override
//   void initState() {
//     // TODO: implement initState
//     _loadData();
//   }
//   Future<void> _loadData() async{
// final prefs=await SharedPreferences.getInstance();
// setState(() {
//   _name = prefs.getString('name') ?? '';
//   _age = prefs.getInt('age') ?? 0;
//   _gender = prefs.getString('gender') ?? '';
//   _country = prefs.getString('country') ?? '';
//   _hobbies = prefs.getString('hobbies') ?? '';
// });
//
//   }
//   Future<void> _saveData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('name', _name);
//     await prefs.setInt('age', _age);
//     await prefs.setString('gender', _gender);
//     await prefs.setString('country', _country);
//     await prefs.setString('hobbies', _hobbies);
//   }
//
//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       _saveData();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Profile saved')),
//       );
//     }
//   }
//   var count=0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Stateful'),
//       ),
//       body: Center(
//
//       child: Form(
//       key: _formKey,
//
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Counter $count'),
//             ElevatedButton(onPressed: () {
//               setState(() {
//                 count++;
//                 // _submitForm();
//               });
//             }, child: Text("Increment")),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: 'Name',
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your name';
//                 }
//                 return null;
//               },
//               onSaved: (value) {
//                 _name = value!;
//               },
//               initialValue: _name,
//             ),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: 'Name',
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your name';
//                 }
//                 return null;
//               },
//           onSaved: (value) async {
//           var prefs = await SharedPreferences.getInstance();
//           prefs.setString('name', value!);},
//               initialValue: _hobbies
//             )
//
//           ],
//         ),
//       )),
//     );
//   }
// }