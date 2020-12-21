
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mbtc_visual_recognition/main.dart';
import 'package:mbtc_visual_recognition/widgets/display_picture_screen.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {

  final CameraDescription camera;

  CameraScreen({ @required this.camera });

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

//Emulator camera
//https://stackoverflow.com/questions/13818389/android-emulator-camera-custom-image/55749661

class _CameraScreenState extends State<CameraScreen> {

  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      try {
                        await _initializeControllerFuture;

                        final path = join(
                          (await getTemporaryDirectory()).path,
                          '${DateTime.now()}.png',
                        );

                        await _controller.takePicture(path);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(image: File(path)),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Container(),
                  Visibility(
                    visible: false,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 48),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset('assets/images/gallery.png', scale: 0.60),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
