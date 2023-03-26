import 'dart:convert';

import 'package:first_app/abc.dart';
import 'package:first_app/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Article App',
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
      home: MyHomePage(title: 'Assigment',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  var log;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      getValue();
    });



  }
  var name=TextEditingController();
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
        title: Text("Assigment App"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Icon(Icons.document_scanner,size: 60.0,)
            // ElevatedButton(onPressed: (){
            //  getValue();
            // }, child: Text("Login"))

          ],
        ),
      )
    );
  }

  void getValue() async {
    var prefs=await SharedPreferences.getInstance();
    display=prefs.getString("name");
    log=prefs.getBool("log");
    if(log==true){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp3()));
      // print(""+log);
    }
    else{
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage2(title: "login")));
    }


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