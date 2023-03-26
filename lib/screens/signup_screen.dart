
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'main_screen.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'sign up';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? pass;
  String? phone;
  String? country;
  String? language;
  final _formKey = GlobalKey<FormState>();
  //AuthServices _authServices = new AuthServices();
  bool? _isLoading = false;
  //static final FirebaseAuth _auth = FirebaseAuth.instance;

  onSignup() async{
    bool valid = _formKey.currentState!.validate();
    if(valid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        var cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: pass!);
        // print('------------------ ${cred.user!.uid}');
        // await FirebaseFirestore.instance.collection('users')
        //     .doc(cred.user!.uid).set({
        //   'email': email,
        //   'password': pass,
        //   'phone': phone,
        //   'language': language,
        //   'country': country,
        // });
        setState(() {_isLoading = false;});
        Navigator.pushNamed(context, MainScreen.id);
      } on FirebaseAuthException catch(e) {
        if (e.code == 'weak-password') {
          setState(() {_isLoading = false;});
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Weak password'))
          );
        } else if (e.code == 'email-already-in-use') {
          setState(() {_isLoading = false;});
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('email already in use'))
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50,),
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
                    const SizedBox(height: 10,),
                    CustomTextField(
                      text: 'Phone',
                      textInputType: TextInputType.number,
                      setValue: (value){
                        phone = value.trim();
                      },
                      validation: (value){
                        if(value.isEmpty) return 'Enter your phone';
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    CustomTextField(
                      text: 'Language',
                      setValue: (value){
                        language = value.trim();
                      },
                      validation: (value){
                        if(value.isEmpty) return 'Enter your language';
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    CustomTextField(
                      text: 'Country',
                      setValue: (value){
                        country = value.trim();
                      },
                      validation: (value){
                        if(value.isEmpty) return 'Enter your country';
                        return null;
                      },
                    ),
                    const SizedBox(height: 25,),
                    CustomButton(
                      text: "Signup",
                      onClick: (){
                        onSignup();
                      },
                      isLoading: _isLoading!,
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5,),
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login now',
                            style: TextStyle(
                              color: Colors.brown.shade300,
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
      ),
    );
  }
}
