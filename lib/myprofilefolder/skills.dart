import 'package:flutter/material.dart';

class SkillPage extends StatefulWidget {
  @override
  _SkillPageState createState() => _SkillPageState();
}
/// SingleTickerProviderStateMixin use for the animation
class _SkillPageState extends State<SkillPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isAnimating = true;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _startScraping();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _startScraping() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Update your UI elements here
    });
  }

  void _toggleAnimation() {
    setState(() {
      if (isAnimating) {
        _animationController.stop();
      } else {
        _animationController.repeat(reverse: true);
      }
      isAnimating = !isAnimating;
    });
  }
  //
  // void _showFlutterMessage() {
  //   setState(() {
  //     message = "Hi, I know Flutter!";
  //     isAnimating = false;
  //   });
  // }
  //
  // void _showDartMessage() {
  //   setState(() {
  //     message = "Hi, I know Dart!";
  //     isAnimating = false;
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SingleChildScrollView with a Row for scrolling text
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Hi my name is gaurav parmar and I am a flutter developer "
                            "and my skills are flutter, firebase, dart, and scraping",
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),

              GestureDetector(
                onTap: () {
                  _toggleAnimation();
                  //_showFlutterMessage(); // Show message and stop animation
                },
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2.0 * 3.14159,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Flutter',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Visibility(
                visible: !isAnimating,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    children: [

                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),


              GestureDetector(
                onTap: () {
                  _toggleAnimation();
                 //_showDartMessage();// Show message and stop animation
                },
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2.0 * 3.14159,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Dart',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Visibility(
                visible: !isAnimating,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    children: [

                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),

              GestureDetector(
                onTap: () {
                  _toggleAnimation();
                  //_showFlutterMessage(); // Show message and stop animation
                },
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2.0 * 3.14159,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Firebase',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Visibility(
                visible: !isAnimating,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    children: [

                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),

              GestureDetector(
                onTap: () {
                  _toggleAnimation();
                  //_showFlutterMessage(); // Show message and stop animation
                },
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2.0 * 3.14159,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Scraping',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Visibility(
                visible: !isAnimating,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    children: [

                    ],
                  ),
                ),
              ),




              // ... Other GestureDetector widgets for Dart, Firebase, and Scraping ...
            ],
          ),
        ),
      ),
    );
  }
}
