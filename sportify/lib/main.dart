//import 'package:sportify/screens/OTPScrean.dart';

// void main() {
//   runApp(myapp());
// }

// class myapp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: OTPScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sportify/modules/Splash.dart';
import 'package:sportify/modules/loginScreen.dart';
import 'package:sportify/modules/onboardScreen.dart';

import 'package:sportify/modules/userScreens/OTPScreen.dart';
import 'package:sportify/modules/userScreens/Signup.dart';
import 'package:sportify/modules/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        '/welcome': (context) => const Welcome(),
        "/login": (context) => const LoginScreen(),
        "/signup": (context) => const SignupScreen(),
        "/OTPScreen": (context) => OTPScreen(),
        "/OnboardScreen": (context) => const OnboardScreen(
              image: '',
              title: '',
              description: '',
            ),
      },
    );
  }
}
