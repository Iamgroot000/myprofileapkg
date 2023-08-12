// import 'package:flutter/material.dart';
// import 'package:your_splash/your_splash.dart';
//
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen.timed(
//         seconds: 3,
//         route: MaterialPageRoute(builder: (_) => Home()),
//         body: Scaffold(
//           body: InkWell(
//             child: Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: NetworkImage('https://bit.ly/3hD5Tj8'),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home screen!"),
//       ),
//       body: Center(
//         child: Text(
//           "Welcome!",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
//         ),
//       ),
//     );
//   }
// }
