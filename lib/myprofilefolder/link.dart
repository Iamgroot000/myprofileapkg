import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:share/share.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Center(


        child: RadialButton(
          icon: Icon(Icons.phone),
          buttonColor: Colors.green,
          onPress: () {
            // Generate a unique link using uuid
            String uniqueLink = 'https://yourwebsite.com/page/' + Uuid().v4();

            // Share the link using the share package
            Share.share('Check out this link: $uniqueLink');
          },
        ),
      ),
    );
  }
}

class RadialButton extends StatelessWidget {
  final Icon icon;
  final Color buttonColor;
  final VoidCallback onPress;

  RadialButton({
    required this.icon,
    required this.buttonColor,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPress,
      child: icon,
      backgroundColor: buttonColor,
    );
  }
}


