import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class Profile extends StatelessWidget{
//   const Profile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       title: 'Flutter Demo',
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
//       home: ProfilePage(),
//     );
//
//
//   }
//
// }
class ProfilePage extends StatefulWidget {
    @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var name;
  var age;
  var country;
  var hobby;
  var phone;
  var gender;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Profile Page'),
      ),
      body:Container(
        // alignment: MainAxisAlignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Name: $name',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Age: $age',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Gender: $gender',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Country: $country',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hobbies: $hobby',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Mobile No.: $phone',
                style: TextStyle(fontSize: 20),
              ),
            ),

          ],
        ),
      )


    );
  }
  void getValue() async {
    var prefs=await SharedPreferences.getInstance();
    // display=prefs.getString("name");
    // var prefs=await SharedPreferences.getInstance();
    name=prefs.getString("name").toString();
    age=prefs.getString("age").toString();
    phone=prefs.getString("number").toString();
    country=prefs.getString("country").toString();
    gender=prefs.getString("gender").toString();
    hobby=prefs.getString("hobby");
    print(gender);
    setState(() {

    });
    // // prefs.setBool('log', true);
    // print(_formKey.currentState!.validate());
    // print(display);

  }
}
