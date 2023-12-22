import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sportify/shared/sharedComponents/components.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}


class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPassword = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUpWithPhoneNumber(BuildContext context) async {
  String phoneNumber = '+2${phoneController.text}'; // Format the phone number as needed
  await auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential result = await auth.signInWithCredential(credential);
        User? user = result.user;
        if (user != null) {
          // Navigate to the next screen or perform necessary actions
          Navigator.pushReplacementNamed(context, '/OTPScreen');
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
          '/OTPScreen',
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
                DefaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  label: 'Name',
                  prefix: Icons.person,
                  validate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Name must not be empty';
                    }
                    String pattern = r'^[a-zA-Z ]{3,}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Please write a valid name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenSize.height * 0.03),
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
                SizedBox(height: screenSize.height * 0.03),
                DefaultFormField(
                  controller: ageController,
                  type: TextInputType.number,
                  label: 'Age',
                  prefix: Icons.calendar_today,
                  validate: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Age must not be empty';
                    }
                    int? age = int.tryParse(value);
                    if (age == null || age < 4 || age > 100) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenSize.height * 0.03),
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
                SizedBox(height: screenSize.height * 0.05),
                DefaultButton(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      // Only navigate if the form is valid
                      Navigator.pushNamed(context, '/OTPScreen');
                    }
                  },
                  text: 'SIGN UP',
                  isUpper: true,
                  radius: 5, onPressed: () => signUpWithPhoneNumber(context),
                ),
                SizedBox(height: screenSize.height * 0.02),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account?',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: fdefaultColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Login Now',
                            style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: sdefaultcolor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
