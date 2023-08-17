import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class MyvdocumentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Upload to Firebase Storage',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
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
  FirebaseStorage storage = FirebaseStorage.instance;
  var videoResult;
  String videoUrl = "";
  bool uploaded = false;
  VideoPlayerController? _videoPlayerController;
  bool _isPlaying = false;

  Future<void> _uploadFileToFirebase(File file) async {
    try {
      Reference ref = storage.ref().child('uploaded_files/${file.path.split('/').last}');
      await ref.putFile(file);
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // allowMultiple: true,
      type: FileType.custom, // Allow only video files
      allowedExtensions: ['mp4'],
    );

    if (result != null) {
      PlatformFile file = result.files.single;

      if (file.extension == 'mp4') {
        try {
          Reference ref = FirebaseStorage.instance.ref().child('uploaded_files/${DateTime.now().millisecondsSinceEpoch}.${file.extension}');
          UploadTask uploadTask = ref.putFile(File(file.path!));

          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

          videoUrl = await taskSnapshot.ref.getDownloadURL();
          uploaded = true;

          print("This is video url: $videoUrl");

          _videoPlayerController = VideoPlayerController.network(videoUrl)
            ..initialize().then((_) {
              setState(() {
                _isPlaying = false;
                _fileWidgets.add(
                  Column(
                    children: [
                      AspectRatio(
                        aspectRatio: _videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController!),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                            onPressed: () {
                              setState(() {
                                if (_isPlaying) {
                                  _videoPlayerController!.pause();
                                } else {
                                  _videoPlayerController!.play();
                                }
                                _isPlaying = !_isPlaying;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
            });

          _videoPlayerController!.addListener(() {
            if (_videoPlayerController!.value.position >= _videoPlayerController!.value.duration) {
              setState(() {
                _isPlaying = false;
              });
            }
          });

          _videoPlayerController!.setLooping(false);

        } catch (e) {
          print('Error uploading video: $e');
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
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
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
          //color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  OutlinedButton(
                    onPressed: _openFilePicker,
                    child: Text('Add Your Video'),
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    child: uploaded == false
                        ? const Icon(Icons.video_call, color: Colors.orangeAccent, size: 100,)
                        : AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoPlayer(_videoPlayerController!),
                    ),
                  )
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
