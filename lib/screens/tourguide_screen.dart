import 'package:flutter/material.dart';

class TourGuideScreen extends StatefulWidget {
  static String id ='tour guide';
  const TourGuideScreen({Key? key}) : super(key: key);

  @override
  State<TourGuideScreen> createState() => _TourGuideScreenState();
}

class _TourGuideScreenState extends State<TourGuideScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Tour guide',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
