import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controls/auth_controls.dart';
import 'package:tiktok_clone/screens/Home_screen/Home_screen.dart';
import 'package:tiktok_clone/screens/login_screen.dart';
import 'package:tiktok_clone/screens/signUp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCOojk7SckXLU1DwM_IOQjKdm1gb42_INA',
        appId: '1:698247112398:web:be35b2dc43dc81030d929f',
        messagingSenderId: '698247112398',
        projectId: 'tiktok-clone-1f0b9',
        storageBucket: 'tiktok-clone-1f0b9.appspot.com',
      ),
    ).then((value) {
      Get.put(AuthControls());
    });
  } else {
    await Firebase.initializeApp();
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
      getPages: [
        GetPage(name: '/LoginScreen', page: () => LoginScreen()),
        GetPage(name: '/HomeScreen', page: () => HomeScreen()),
        GetPage(name: '/SignUpScreen', page: () => SignUpScreen()),
      ],
    );
  }
}
