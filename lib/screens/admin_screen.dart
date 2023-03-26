import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  static String id = 'admin';
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Admin',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
