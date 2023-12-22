import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async'; // Import this for Timer
import 'package:sportify/shared/sharedComponents/components.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _firstDigitController = TextEditingController();
  final TextEditingController _secondDigitController = TextEditingController();
  final TextEditingController _thirdDigitController = TextEditingController();
  final TextEditingController _fourthDigitController = TextEditingController();
  final TextEditingController _fifthDigitController = TextEditingController();
  final TextEditingController _sixthDigitController = TextEditingController();



  Timer? _timer;
  int _start = 120; // 2 minutes in seconds
  FirebaseAuth auth = FirebaseAuth.instance;
  String? verfy;
  @override
  void initState() {
    super.initState();
    startTimer();
  //  phoneauth();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer?.cancel();
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    _firstDigitController.dispose();
    _secondDigitController.dispose();
    _thirdDigitController.dispose();
    _fourthDigitController.dispose();
    _fifthDigitController.dispose();
    _sixthDigitController.dispose();


  }

  // Future<void> signInWithOTP(BuildContext context, String verificationId, String smsCode) async {
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (kDebugMode) {
  //         print('Error: $e');
  //       }
  //       // Handle verification failure
  //     },
  //     codeSent: (String verificationId, int? resendToken) async {
  //       verfy = verificationId;
       
  // },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }
   Future<void> signInWithOTP(BuildContext context, String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
       try {
      UserCredential result = await auth.signInWithCredential(credential);
      User? user = result.user;

      if (user != null) {
        // Navigate to the next screen or perform necessary actions
        Navigator.pushReplacementNamed(context, '/splash');
      } else {
        // Handle sign in failure
        print('Sign in failed');
      }
    } catch (e) {
      // Handle sign in error
      print('Sign in error: $e');
    }
  }
// sendcode() async {
//    try{
//       String smsCode =  _firstDigitController.text+_secondDigitController.text+_thirdDigitController.text+_fourthDigitController.text
//           + _fifthDigitController.text+_sixthDigitController.text;       
//     // Create a PhoneAuthCredential with the code
//      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verfy!, smsCode: smsCode);
//         // Sign the user in (or link) with the credential
//         await auth.signInWithCredential(credential).then((value){
//           if(value.user != null){
//             Navigator.pushNamed(context, '/welcomescreen');//change it to the next page
//           }
//         });

//         }catch(e){
//             if (kDebugMode) {
//         print("Error verifying OTP: $e");
//       }
//         }
// }
  
        

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String verificationId = args['verificationId'];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 85.79),
                Text(
                  'Verification Code',
                  style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: fdefaultColor),
                ),
                SizedBox(height: 15),
                Text(
                  'we have send the code verification to',
                  style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: sdefaultcolor),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '0103******83',
                      style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: sdefaultcolor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Change phone number?',
                        style: GoogleFonts.outfit(
                            fontSize: 15, color: fdefaultColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 1),
                    OTPTextField(
                        controller: _firstDigitController,
                        onChanged: (value) {}),
                    SizedBox(width: 1),
                    OTPTextField(
                        controller: _secondDigitController,
                        onChanged: (value) {}),
                    SizedBox(width: 1),
                    OTPTextField(
                        controller: _thirdDigitController,
                        onChanged: (value) {}),
                    SizedBox(width: 1),
                    OTPTextField(
                        controller: _fourthDigitController,
                        onChanged: (value) {}),
                    SizedBox(width: 1),
                    OTPTextField(
                        controller: _fifthDigitController,
                        onChanged: (value) {})
                        ,SizedBox(width: 1),
                    OTPTextField(
                        controller: _sixthDigitController,
                        onChanged: (value) {})
                        ,SizedBox(width: 1)
                        
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Resend code after',
                      style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: sdefaultcolor),
                    ),
                    // Text(
                    //   ' 1:36',
                    //   style: TextStyle(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.normal,
                    //       color: fdefaultColor),
                    // ),

                    Text(
                      ' ${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}',
                      style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: fdefaultColor),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     fButton(text: 'Confirm',function: () {signInWithOTP(context, verificationId,_firstDigitController.text+
                     _secondDigitController.text+_thirdDigitController.text+_fourthDigitController.text+_fifthDigitController.text+
                     _sixthDigitController.text);},),
                       SizedBox(
                        width: 25,
                      ),
                      _resendButton(context,verificationId,_firstDigitController.text+
                     _secondDigitController.text+_thirdDigitController.text+_fourthDigitController.text+_fifthDigitController.text+
                     _sixthDigitController.text),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _confirmButton(BuildContext context) {
  //   return fButton(
  //     text: 'Confirm',
  //     function: () {signInWithOTP(context, verificationId, otpController.text)},
  //   );
  // }

Widget _resendButton(BuildContext context, String verificationId, String smsCode) {
  return DefaultButton(
    text: 'Resend',
    width: 170,
    height: 50,
    function: () {
      setState(() {
        _start = 120;
        startTimer();
      });
    },
    onPressed: () => signInWithOTP(context, verificationId, smsCode), // Empty function as a placeholder
  );
  
}



}
