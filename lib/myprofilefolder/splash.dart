//
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:whatsapp_unilink/whatsapp_unilink.dart';
//
//
// class MyPlugin extends StatelessWidget {
//   launchWhatsApp() async {
//     final link = WhatsAppUnilink(
//       phoneNumber: '+91- 7536868981',
//       text: "Hey there!",
//     );
//     await launch('$link');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             launchWhatsApp();
//           },
//           child: Text("Go to Whatsapp"),
//         ),
//       ),
//     );
//   }
// }