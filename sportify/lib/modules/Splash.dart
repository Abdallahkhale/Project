import 'package:flutter/material.dart';
import 'package:sportify/modules/onboardScreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay and then navigate to the next page
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => OnboardScreen(
                  image: '',
                  title: '',
                  description: '',
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF30F020),
      body: Center(
        child: Container(
          width: 450.0,
          height: 600.0,
          decoration: const BoxDecoration(
            color: Color(0xFF30F020),
          ),
          child: Center(
            child: Image.asset(
              'assets/splash.png',
              width: 270.0,
              height: 404.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      body: const Center(
        child: Text('This is the next page!'),
      ),
    );
  }
}
