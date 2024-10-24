import 'package:flutter/cupertino.dart';
import 'package:online_food_order/pages/login_page.dart';
import 'package:online_food_order/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget{
  const LoginOrRegister ({super.key});

  @override
  State<StatefulWidget> createState() => _LoginOrRegisterState();
   
  }

  class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially, show login page
    
    bool showLoginPage = true;
    
    // toogle between login and register page
  
  void tooglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
   if (showLoginPage){
     return LoginPage(
         onTap: tooglePages);
   } else {
     return RegisterPage(
         onTap: tooglePages);
   }
  }
  
  //
  
  }
