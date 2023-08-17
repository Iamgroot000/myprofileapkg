import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';



class VideoUploadScreen extends StatefulWidget {
  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  PickedFile? _pickedVideo;

  Future<void> _pickVideo() async {
    PickedFile? pickedVideo = (await _picker.pickVideo(source: ImageSource.gallery)) as PickedFile?;
    setState(() {
      _pickedVideo = pickedVideo;
    });
  }

  Future<void> _uploadVideo() async {
    if (_pickedVideo != null) {
      String fileName = DateTime.now().toString() + '.mp4';
      Reference ref = storage.ref().child('videos/$fileName');

      final UploadTask uploadTask = ref.putFile(
        File(_pickedVideo!.path),
        SettableMetadata(contentType: 'video/mp4'),
      );

      await uploadTask.whenComplete(() => print('Video uploaded'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_pickedVideo != null)
              VideoPlayerWidget(videoPath: _pickedVideo!.path),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Pick a Video'),
            ),
            ElevatedButton(
              onPressed: _uploadVideo,
              child: Text('Upload Video'),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final String videoPath;

  VideoPlayerWidget({required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        child: VideoPlayer(VideoPlayerController.file(File(videoPath)))
    );
  }
}
