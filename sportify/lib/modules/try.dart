

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneSignUpScreen extends StatelessWidget {
  final TextEditingController phoneNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithPhoneNumber(BuildContext context) async {
    String phoneNumber = '+2${phoneNumberController.text}'; // Format the phone number as needed

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential result = await _auth.signInWithCredential(credential);
        User? user = result.user;
        if (user != null) {
          // Navigate to the next screen or perform necessary actions
          Navigator.pushReplacementNamed(context, '/next_screen');
        } else {
          // Handle sign up failure
          print('Sign up failed');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Navigate to OTP verification screen passing verificationId
        Navigator.pushNamed(
          context,
          '/otp_screen',
          arguments: {'verificationId': verificationId},
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle code auto retrieval timeout
        print('Code auto retrieval timeout');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => signUpWithPhoneNumber(context),
              child: Text('Sign Up with Phone'),
            ),
          ],
        ),
      ),
    );
  }
}


//2. *شاشة التحقق من رمز التحقق (OTP Verification Screen):*


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPScreen extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithOTP(BuildContext context, String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    try {
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      if (user != null) {
        // Navigate to the next screen or perform necessary actions
        Navigator.pushReplacementNamed(context, '/next_screen');
      } else {
        // Handle sign in failure
        print('Sign in failed');
      }
    } catch (e) {
      // Handle sign in error
      print('Sign in error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String verificationId = args['verificationId'];

    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                hintText: 'Enter the OTP received',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => signInWithOTP(context, verificationId, otpController.text),
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
