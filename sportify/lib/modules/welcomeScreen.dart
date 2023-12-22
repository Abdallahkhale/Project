import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportify/shared/sharedComponents/components.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 125, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/new_welcome.png',
                  height: 100,
                ),
                const SizedBox(height: 99),
                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome to Sportify application',
                      style: GoogleFonts.outfit(
                        fontSize: 29,
                        fontWeight: FontWeight.w600,
                        color: fdefaultColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 75),
                _loginButton(context),
                const SizedBox(height: 26),
                _signupButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return fButton(
      function: () => Navigator.pushNamed(context, '/login'),
      text: 'LOGIN',
    );
  }

  Widget _signupButton(BuildContext context) {
    return fButton(
      function: () => Navigator.pushNamed(context, '/signup'),
      text: 'SIGN UP',
      width: 170,
      height: 50,
      isUpper: true, 
    );
  }
}
