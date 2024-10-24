import 'package:flutter/material.dart';
import 'package:online_food_order/components/my_button.dart';
import 'package:online_food_order/services/auth/auth_service.dart';
import '../components/my_textfield.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login method
  Future<void> login() async {
    // get instance of auth service
    final _authService = AuthService();
    // try sign in
    try {
      await _authService.signUpWithEmailPassword(emailController.text, passwordController.text,);
    }

    // display  an errors

    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ),
      );
    }
  }
/*
    // Navigate to home page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
  */


  // forgot password
  void forgotPw(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: const Text("User tapped forgot password"),
    ),
    );
  }



  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.15), // Top spacing

                // Logo or Icon
                Icon(
                  Icons.lock_open_rounded,
                  size: 100,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(height: 25),

                // App Slogan or Title
                Text(
                  "Food Delivery App",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 35),

                // Email textfield
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                  borderRadius: 30, // Rounded corners for text fields
                ),

                const SizedBox(height: 15),

                // Password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                  borderRadius: 30, // Rounded corners for text fields
                ),
                const SizedBox(height: 20),

                // Sign In Button
                MyButton(
                  text: "Sign In",
                  onTap: login,
                  borderRadius: 30, // Rounded corners for button
                  buttonColor: Colors.orangeAccent, // Make the button stand out
                ),
                const SizedBox(height: 40),

                // "Not a member? Register now" text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.15), // Bottom spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}
