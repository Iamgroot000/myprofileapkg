




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class skillspage extends StatefulWidget {
  const skillspage({super.key});

  @override
  State<skillspage> createState() => _skillspageState();
}

class _skillspageState extends State<skillspage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 220,
        width: 340,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.deepPurple, width: 2.0),
        ),



      ),
    );

  }
}
