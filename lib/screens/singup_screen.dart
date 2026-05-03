import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_buttons.dart';
import 'package:flutter_application_1/components/my_textfield.dart';
import 'package:flutter_application_1/helpers/validators.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final GlobalKey<FormState> keyFormState = GlobalKey<FormState>();

  late TextEditingController userController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    userController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUpUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();

      Fluttertoast.showToast(
        msg: "Account created successfully",
        backgroundColor: Colors.green,
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, "LoginScreen");

    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? "Signup failed",
        backgroundColor: Colors.red,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        backgroundColor: Colors.red,
      );
    }
  }

  void displayAToast() {
    Fluttertoast.showToast(
      msg: "Your entries are not valid",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: keyFormState,
            child: Column(
              children: [
                const Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // Username
                MyTextfield(
                  TFHintText: "Username",
                  TFIcon: const Icon(Icons.person),
                  TFController: userController,
                  isObscure: false,
                  TFValidator: (val) => emptyValidationFct(val),
                ),

                const SizedBox(height: 12),

                // Email
                MyTextfield(
                  TFHintText: "Email",
                  TFIcon: const Icon(Icons.email),
                  TFController: emailController,
                  isObscure: false,
                  TFValidator: (val) => emailValidationFct(val),
                ),

                const SizedBox(height: 12),

                // Password
                MyTextfield(
                  TFHintText: "Password",
                  TFIcon: const Icon(Icons.lock),
                  TFController: passwordController,
                  isObscure: true,
                  TFValidator: (val) => pwdValidationFct(val),
                ),

                const SizedBox(height: 12),

                // Confirm Password
                MyTextfield(
                  TFHintText: "Confirm Password",
                  TFIcon: const Icon(Icons.lock),
                  TFController: confirmPasswordController,
                  isObscure: true,
                  TFValidator: (value) =>
                      pwdConfirmValidationFct(value, passwordController.text),
                ),

                const SizedBox(height: 16),

                // Signup Button
                MyElevatedButton(
                  buttonLable: "Signup",
                  onPressedFct: () {
                    if (keyFormState.currentState!.validate()) {
                      signUpUser();
                    } else {
                      displayAToast();
                    }
                  },
                ),

                const SizedBox(height: 12),

                const Text(
                  "OR",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Google Sign-In (not implemented yet)
                MyElevatedButton(
                  buttonLable: "Sign in with Google",
                  onPressedFct: () {
                    Fluttertoast.showToast(
                      msg: "Google Sign-In not implemented yet",
                    );
                  },
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "LoginScreen");
                      },
                      child: const Text("Login"),
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