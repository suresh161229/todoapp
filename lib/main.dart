import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/Homepage.dart';
import 'package:todoapp/Providers/LoginProvider.dart';
import 'package:todoapp/Login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todoapp/Styles.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyAU7O5rmqsuqC0EDi5PB26JorJyt1zrJkA",
      appId: "1:557282527408:android:c384c9ee00c724157c9375",
      messagingSenderId: "557282527408",
      projectId:
      "todoapp-fb58f"));
  runApp(MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (ctx) => LoginProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
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
        // is not restar
        primarySwatch: Colors.blue,

      ),

      home: const LandingScreen(),
    );
  }
}
class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2))
        .then((value) => _checkAuthentication());
    //  success();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SpinKitFadingCube(
            size: size.height * 0.075,
            color: btnColor,
          ),
        ),
      ),
    );
  }

  _checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString("email") == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      }
    } catch (e) {
      return e;
    }
  }

  // success() async {
  //   var response = await http.post(
  //       Uri.parse("http://api.schedyo.com/api/Login/Login"),
  //       body: {"email": "super@gmail.com", "password": "123456"});
  //   print(response.body);
  // }
}
