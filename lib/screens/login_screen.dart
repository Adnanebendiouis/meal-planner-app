import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_buttons.dart';
import 'package:flutter_application_1/components/my_textfield.dart';
import 'package:flutter_application_1/helpers/validators.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> keyFormState = GlobalKey<FormState>();

  late TextEditingController userController;
  late TextEditingController pwdController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    pwdController = TextEditingController();
  }

  @override
  void dispose() {
    userController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  // 🔥 LOGIN FUNCTION
  Future<void> loginUser() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userController.text.trim(),
        password: pwdController.text.trim(),
      );

      final user = userCredential.user;

      if (user == null) {
        Fluttertoast.showToast(
          msg: "Login failed",
          backgroundColor: Colors.red,
        );
        return;
      }

      // ✅ Email verification check
      if (!user.emailVerified) {
        Fluttertoast.showToast(
          msg: "Please verify your email first",
          backgroundColor: Colors.orange,
        );
        await FirebaseAuth.instance.signOut();
        return;
      }

      Fluttertoast.showToast(
        msg: "Login successful",
        backgroundColor: Colors.green,
      );

      Navigator.pushReplacementNamed(context, "HomeScreen");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? "Login failed",
        backgroundColor: Colors.red,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  // 🔥 FORGOT PASSWORD FUNCTION (FIXED)
  Future<void> resetPassword() async {
    if (isLoading) return;

    String email = userController.text.trim();

    // ✅ Validate email
    if (emailValidationFct(email) != null) {
      Fluttertoast.showToast(
        msg: "Enter a valid email",
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Firebase does NOT return a list here → FIXED
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      Fluttertoast.showToast(
        msg: "Reset link sent to your email",
        backgroundColor: Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? "Error occurred",
        backgroundColor: Colors.red,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  void displayAToast() {
    Fluttertoast.showToast(
      msg: "Your entries are not valid",
      backgroundColor: Colors.red,
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
                  "Welcome to my app",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                // Email
                MyTextfield(
                  TFHintText: "Email",
                  TFIcon: const Icon(Icons.email),
                  TFController: userController,
                  isObscure: false,
                  TFValidator: (val) => emailValidationFct(val),
                ),

                const SizedBox(height: 12),

                // Password
                MyTextfield(
                  TFHintText: "Password",
                  TFIcon: const Icon(Icons.lock),
                  TFController: pwdController,
                  isObscure: true,
                  TFValidator: (val) => emptyValidationFct(val),
                ),

                const SizedBox(height: 16),

                // Login Button
                MyElevatedButton(
                  buttonLable: isLoading ? "Loading..." : "Login",
                  onPressedFct: () {
                    if (keyFormState.currentState!.validate()) {
                      loginUser();
                    } else {
                      displayAToast();
                    }
                  },
                ),

                // Forgot Password
                MyElevatedButton(
                  buttonLable:
                      isLoading ? "Please wait..." : "Forgot Password",
                  onPressedFct: resetPassword,
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, "SignupScreen");
                      },
                      child: const Text("Sign up"),
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