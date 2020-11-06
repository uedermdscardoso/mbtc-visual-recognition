
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mbtc_visual_recognition/camera_screen.dart';
import 'package:mbtc_visual_recognition/take_picture_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  runApp(App(camera: firstCamera));
}


class App extends StatelessWidget {

  CameraDescription camera;

  App({ this.camera });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: CameraScreen(camera: camera),
    );
  }
}

