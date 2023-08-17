import 'dart:io';

import 'package:animated_radial_menu/animated_radial_menu.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myprofileapk/document.dart';
import 'package:myprofileapk/projects.dart';
import 'package:myprofileapk/skills.dart';
import 'package:myprofileapk/videointro.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../floating.dart';
import 'Experincepage.dart';
import 'Qualification.dart';





class page1 extends StatefulWidget {
  final image;

  const page1( this.image, {super.key});



  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children : [
        Container(
          color: Colors.black
          ,
          child: Column(
            children: [
              Center(
                child: Container(
                  height:650,
                  width: 400,
                 // color: Colors.white,
                  child: SingleChildScrollView( // Wrap with SingleChildScrollView
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 58,),
                        CircleAvatar(
                          radius: 100,
                          foregroundImage: widget.image == ""?
                          Image.asset("assets/gaurav.jpg").image:
                              /// use widget.image when you want to updtae your image through previous page
                          Image.file(File(widget.image)).image,
                        ),

                        SizedBox(height: 10),
                        Text(
                          'Gaurav Parmar',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Flutter Developer',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () { Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  SkillsPage ()), // Replace SecondScreen() with your desired screen widget
                                );},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                ),
                                child: Text("Skills"),
                              ),
                            ),
                          ],
                        ),



                        SizedBox(height: 10),
                        // Divider(  // Add a divider line here
                        //   color: Colors.blueAccent,
                        //   height: 20,
                        //   thickness: 1,
                        //   indent: 30,
                        //   endIndent: 30,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () { Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyexperienceApp  ()), // Replace SecondScreen() with your desired screen widget
                                );},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                ),
                                child: Text("Experince"),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 130,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  MyProjectApp  ()), // Replace SecondScreen() with your desired screen widget
                                );},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                ),
                                child: Text("Projects "),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 160,
                              child: ElevatedButton(
                                onPressed: () { Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  MyqualificationApp  ()), // Replace SecondScreen() with your desired screen widget
                                );},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                ),
                                child: Text("Qualifications "),
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 160,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>   MydocumentApp(),),);
                                  // Replace SecondScreen() with your desired screen widget
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                ),
                                child: Text("My Documents "),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 160,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>   VideoUploadScreen (),),);

                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                ),
                                child: Text("Video Introduction "),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),


                ),
              ),





    // Stack(
              //   children: [
              //     Row(
              //       children: [
              //         Align(
              //           alignment: Alignment.bottomRight,
              //           child: Container(
              //             height: 100,
              //             width: 100,
              //             color: Colors.green,
              //           ),
              //         ),
              //         // Add other widgets to the Column if needed
              //       ],
              //     ),
              //     // Add other Stack children if needed
              //   ],
              // )

            ],),
        ),
        Positioned(
          bottom: 0, // Aligns the bottom edge of the child to the bottom edge of the Stack
          right: 100,  // Aligns the right edge of the child to the right edge of the Stack
          child: Container(
            height: 240,
            width: 200,
            child: RadialMenu(
    children: [
      ///button which is in bottom center ,
      RadialButton(
        icon: Icon(Icons.facebook),
        buttonColor: Colors.blue,
        onPress: () {
          _showUrlDialog(context, _launchURL);
        },
      ),

      /// call features
      RadialButton(
        icon: Icon(Icons.phone),
        buttonColor: Colors.green,
        onPress: () {
          _showPhoneNumberDialog(context);
        },
      ),
      RadialButton(
        icon: Icon(Icons.no_encryption_gmailerrorred),
        buttonColor: Colors.teal,
        onPress: () {
          _launchEmail();
        },
      ),

      RadialButton(
        icon: Icon(Icons.no_encryption_gmailerrorred),
        buttonColor: Colors.orangeAccent,
        onPress: () {
          _generateAndShareLink();
        },
      ),




      RadialButton(
    icon: Icon(Icons.whatshot),
    buttonColor: Colors.yellow,
    onPress: () {
      launchWhatsApp();

    }
    )
    ]
    ),

    ),
    ),
        Container(
          height: 40,
            width: 600,
          color: Colors.yellow,
        //  child: Center(child: Text("MyProfile")),
        )
    ]);








  }
  getImage(){

  }
}
/// function for url , which we are calling in radial button,
void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
/// add your number with the call icon , it is calling in phone icon
void _launchPhoneCall(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch phone call';
  }
}

void _showPhoneNumberDialog(BuildContext context) {
  TextEditingController _phoneNumberController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Enter Phone Number'),
        content: TextField(
          controller: _phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(labelText: 'Phone Number'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String phoneNumber = _phoneNumberController.text;
              Navigator.of(dialogContext).pop();
              _launchPhoneCall(phoneNumber);
            },
            child: Text('Call'),
          ),
        ],
      );
    },
  );
}

void _showUrlDialog(BuildContext context, Function(String) launchUrlCallback) {
  TextEditingController _urlController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Enter URL'),
        content: TextField(
          controller: _urlController,
          decoration: InputDecoration(labelText: 'URL'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String url = _urlController.text;
              Navigator.of(dialogContext).pop();
              launchUrlCallback(url);
            },
            child: Text('Open'),
          ),
        ],
      );
    },
  );
}


void _launchEmail() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'recipient@example.com', // Replace with your default email address
    query: 'subject=Regarding%20Your%20App&body=Hello,%20I%20have%20a%20question...', // You can customize the subject and body here
  );

  final String emailUrl = params.toString();

  if (await canLaunch(emailUrl)) {
    await launch(emailUrl);
  } else {
    final Uri fallbackParams = Uri(
      scheme: 'mailto',
      path: 'gaurprmr12@gmail.com', // Replace with your fallback/default email address
      query: 'subject=Regarding%20Your%20App&body=Hello,%20I%20have%20a%20question...',
    );
    final String fallbackEmailUrl = fallbackParams.toString();

    if (await canLaunch(fallbackEmailUrl)) {
      await launch(fallbackEmailUrl);
    } else {
      throw 'Could not launch email';
    }
  }
}
/// For linking my whatsapp
launchWhatsApp() async {
  final link = WhatsAppUnilink(
    phoneNumber: '+91- 7536868981',
    text: "Hey there!",
  );
  await launch('$link');
}

void _generateAndShareLink() async {
  // Generate your profile link here dynamically
  String profileLink = await generateProfileLink();

  // Use the Share.share method to open the share dialog
  final String text = "Check out my profile: $profileLink";
  await Share.share(text);
}

// Simulating the generation of profile link
Future<String> generateProfileLink() async {
  // You can add your logic here to generate the profile link
  // For now, let's return a dummy link
  return "https://your-website.com/your-profile-page";
}






