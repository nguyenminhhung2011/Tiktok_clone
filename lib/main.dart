import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controls/auth_controls.dart';
import 'package:tiktok_clone/screens/Home_screen/Home_screen.dart';
import 'package:tiktok_clone/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCIFdSeLwiEgjCkYMBj8H-KnaboSZb6gno',
        appId: '1:255649307162:web:5ccec7298c09e085af4fa3',
        messagingSenderId: '255649307162',
        projectId: 'tiktik-tute',
        storageBucket: 'tiktik-tute.appspot.com',
      ),
    ).then((value) {
      Get.put(AuthControls());
    });
  } else {
    await Firebase.initializeApp().then((value) {
      Get.put(AuthControls());
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tiktok clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const LoginScreen(),
      getPages: [
        GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
        GetPage(name: '/HomeScreen', page: () => const HomeScreen()),
      ],
    );
  }
}
