import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportify/shared/sharedComponents/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController smsController = TextEditingController();
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isPassword = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Future<void> _loginWithPhone() async {
  //   try {
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneController.text, // Replace with user's input from phoneController
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         // Automatically sign in the user after verification is done
  //         await _auth.signInWithCredential(credential);
  //         // Navigate to the next screen or perform necessary actions
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         if (kDebugMode) {
  //           print(e.message);
  //         } // Handle verification failure
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         // Store verification ID for later use
  //         String smsCode = smsController.text.trim(); // Get SMS code from user input
  //         PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  //         _auth.signInWithCredential(credential);
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         // Handle timeout scenario
  //       },
  //     );
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenSize.height * 0.08),
                Image.asset(
                  'assets/Sportify2.png',
                  width: screenSize.width * 0.85,
                  height: screenSize.height * 0.3,
                ),
                SizedBox(height: screenSize.height * .02),
                // DefaultFormField(
                //   controller: emailController,
                //   type: TextInputType.emailAddress,
                //   label: 'Email',
                //   prefix: Icons.email,
                //   validate: (String? value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Email must not be empty';
                //     }
                //     return null;
                //   },
                // ),

                DefaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  label: 'Phone Number',
                  prefix: Icons.phone,
                  validate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number must not be empty';
                    }
                    // Regex pattern for an 11-digit phone number
                    String pattern = r'^(?:[+0]9)?[0-9]{11}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid 11-digit phone number';
                    }
                    return null;
                  },
                ),

                SizedBox(height: screenSize.height * 0.06),
                DefaultFormField(
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  label: 'Password',
                  prefix: Icons.lock,
                  isPassword: isPassword,
                  suffix: isPassword ? Icons.visibility_off : Icons.visibility,
                  suffixPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  validate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenSize.height * 0.06),
                fButton(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      print(phoneController.text);
                      print(passwordController.text);
                    }
                  },
                  text: 'LOGIN',
                  isUpper: true,
                  
                ),
                SizedBox(height: screenSize.height * 0.045),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: fdefaultColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Register Now',
                        style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: sdefaultcolor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
