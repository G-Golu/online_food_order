import 'package:flutter/material.dart';
import 'package:online_food_order/pages/login_page.dart';
import 'package:online_food_order/services/auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // register method
  void register() async{

   // get auth service
    final _authService = AuthService();

    // check if password match -> create user
    if (passwordController.text == confirmPasswordController.text){
      // try creating user
      try{
        await _authService.signUpWithEmailPassword(emailController.text, passwordController.text);
      }

      // display any errors
      catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ),
        );
      }
    }

//  if passwords don't match -> show error
  else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password don't match"),
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.15), // Top spacing for larger screens

              // Logo or Icon
              Icon(
                Icons.lock_open_rounded,
                size: 100,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),

              // Message, app slogan
              Text(
                "Let's create an account for you",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 35),

              // Email textfield
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
                borderRadius: 30, // Optional rounded corners
              ),

              const SizedBox(height: 15),

              // Password textfield
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
                borderRadius: 30, // Optional rounded corners
              ),

              const SizedBox(height: 15),

              // Confirm password textfield
              MyTextField(
                controller: confirmPasswordController,
                hintText: "Confirm password",
                obscureText: true,
                borderRadius: 30, // Optional rounded corners
              ),

              const SizedBox(height: 25),

              // Sign Up button
              MyButton(
                text: "Sign Up",
                onTap: () {
                  // Handle the sign-up logic here
                register();
                },
                borderRadius: 30, // Optional rounded corners
                buttonColor: Colors.orangeAccent, // Optional custom button color
              ),

              const SizedBox(height: 25),

              // Already have an account? Login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 4), // Consistent spacing
                  GestureDetector(
                    onTap: widget.onTap, // Redirect to Login page
                    child: Text(
                      "Login now",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.15), // Bottom spacing for larger screens
            ],
          ),
        ),
      ),
    );
  }
}
