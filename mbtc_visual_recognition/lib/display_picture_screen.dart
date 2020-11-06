import 'package:flutter/material.dart';
import 'dart:io';

class DisplayPictureScreen extends StatelessWidget {
  final File image;

  const DisplayPictureScreen({ this.image });

  @override
Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            height: 60,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(Icons.arrow_back_ios, color: Colors.white)
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Text('Image Viewer', style: TextStyle(color: Colors.white, fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold, fontFamily: 'Arial'))
                  ),
                  GestureDetector(
                    onTap: () => print('cliked'),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 0.5),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text('Send', style: TextStyle(color: Colors.white, fontSize: 15, decoration: TextDecoration.none, fontWeight: FontWeight.bold, fontFamily: 'Arial')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(child: Image.file(image)),
      ],
    );
    
  /*return Scaffold(
    appBar: AppBar(backgroundColor: Colors.black, title: Text('Display the Picture', style: TextStyle(color: Colors.white))),
    body: Image.file(image),
  );*/
}
}