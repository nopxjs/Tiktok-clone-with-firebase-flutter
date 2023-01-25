import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktik/constants.dart';
import 'package:toktik/views/screens/auth/signup_screen.dart';

import 'controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokTik',
      theme: ThemeData.light(),
      // .copyWith(
      //   scaffoldBackgroundColor: backgroundColor,
      // ),
      home: SignupScreen(),
    );
  }
}
