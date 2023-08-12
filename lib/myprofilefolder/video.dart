import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class MydocumentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Upload to Firebase Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _fileWidgets = [];

  Future<void> _uploadFileToFirebase(File file) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('uploaded_files/${file.path.split('/').last}');
      await ref.putFile(file);
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Allow only image and PDF files
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.single;

      if (file.extension == 'jpg' || file.extension == 'jpeg' || file.extension == 'png') {
        // Handle image upload as before
        // ...

      } else if (file.extension == 'pdf') {
        try {
          firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
              .ref()
              .child('uploaded_files/${DateTime.now().millisecondsSinceEpoch}.${file.extension}');
          firebase_storage.UploadTask uploadTask = ref.putFile(File(file.path!));

          firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

          String pdfUrl = await taskSnapshot.ref.getDownloadURL();

          setState(() {
            _fileWidgets.add(
              Column(
                children: [
                  PDFView(
                    filePath: pdfUrl,
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          });
        } catch (e) {
          print('Error uploading PDF: $e');
        }
      } else {
        setState(() {
          _fileWidgets.add(
            Text(
              'Unsupported File Type',
              style: TextStyle(fontSize: 16),
            ),
          );
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  OutlinedButton(
                    onPressed: _openFilePicker,
                    child: Text('Add Your Document'),
                  ),
                  Column(
                    children: [
                      OutlinedButton(onPressed: (){},
                          child: Text("OK")),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),
              if (_fileWidgets.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: _fileWidgets),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
