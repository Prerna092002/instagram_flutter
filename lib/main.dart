import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
     await Firebase.initializeApp(
      options:FirebaseOptions(
       apiKey:"AIzaSyDnbC8-uVuUgE31DOFeJh0GIe9axjVPM7c",
       appId:"1:406807092998:web:29bc061965b2b6ca060887",
       messagingSenderId:"406807092998",
       projectId:"instagram-tut-1f870",
       storageBucket:"instagram-tut-1f870.appspot.com",
      ),);
  }else{
      await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor
      ),
      // home:ResponsiveLayout(
      //   webScreenLayout:WebScreenLayout() ,
      //   mobileScreenLayout: MobileScreenLayout(),
      //   ),
      home: SignupScreen(),
    );
  }
}

