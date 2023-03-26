import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:untitled/screens/admin_screen.dart';
import 'package:untitled/screens/signup_screen.dart';
import 'package:untitled/screens/tourguide_screen.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin{
  late AnimationController _controller;
  String? email;
  String? pass;
  final _formKey = GlobalKey<FormState>();
  //AuthServices _authServices = new AuthServices();
  bool _isLoading = false;
  //static final FirebaseAuth _auth = FirebaseAuth.instance;

  onLogin() async{
    bool valid = _formKey.currentState!.validate();
    if(valid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: pass!);
        setState(() {_isLoading = false;});
        var emailList = email!.split('@');
        if(emailList[1] == 'admin.metaphoron')
          Navigator.pushNamed(context, AdminScreen.id);
        else  if(emailList[1] == 'tourguide.metaphoron')
          Navigator.pushNamed(context, TourGuideScreen.id);
        else  Navigator.pushNamed(context, MainScreen.id);
      } on FirebaseAuthException catch(e) {
        setState(() {_isLoading = false;});
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()),)
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'MetaPhoron',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40,),
                  CustomTextField(
                    text: 'Email',
                    setValue: (value){
                      email = value.trim();
                    },
                    validation: (value){
                      if(!value.contains('@') && !value.contains('.')) return 'Not email format';
                      if(value.isEmpty) return 'Enter your email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  CustomTextField(
                    text: 'Password',
                    setValue: (value){
                      pass = value.trim();
                    },
                    validation: (value){
                      if(value.isEmpty) return 'Enter your password';
                      if(value.length < 6) return 'Password is short';
                      return null;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 25,),
                  CustomButton(
                    text: "Login",
                    onClick: (){
                      onLogin();
                    },
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have account yet? ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5,),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: Text(
                          'Sign up now',
                          style: TextStyle(
                            color: Colors.brown.shade100,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
