
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class VisualRecognitionService {

  final _PROTOCOL = "http://";
  final _SERVER = "192.168.0.100";
  final _PORT = 8080;

  Future<String> classify({ File file }) async {
    String url = "${ _PROTOCOL }${ _SERVER }:${ _PORT }/visual-recognition/predict";
    var postUri = Uri.parse(url);
    var request = new MultipartRequest("POST", postUri);

    ByteStream stream;
    String filename = file.path.substring(file.path.lastIndexOf("/")+1, file.path.length);

    request.files.add(
      MultipartFile.fromBytes(
        'image', await file.readAsBytes(),
        filename: filename,
      ),
    );

    String predicted = '';
    await request.send().then((response) async {
      if (response.statusCode == 200) {
        await response.stream.listen((value) {
          predicted = utf8.decode(value);
        });
        //stream = response.stream;
        /*response.stream.listen((value) {
          print('predicted: ${ utf8.decode(value) }');
        });*/
        //print("Uploaded!");
      }
    });

    return predicted;
  }

  String getName({ String result }){
    switch(result){
      case "lagarta":
        return "Lagarta";
      case "percevejo_marrom":
        return "Percevejo Marrom";
      case "percevejo_pequeno":
        return "Percevejo Pequeno";
      case "percevejo_verde":
        return "Percevejo Verde";
    }
  }

  /*try {
      String url = "${ _PROTOCOL }${ _SERVER }:${ _PORT }/visual-recognition/predict";
      var postUri = Uri.parse(url);

      http.MultipartRequest request = new http.MultipartRequest(
          "POST", postUri);

      http.MultipartFile multipartFile = await http.MultipartFile.fromBytes(
          'image', file.readAsBytesSync());

      request.files.add(multipartFile);

      http.StreamedResponse response = await request.send().catchError((e) =>
          print(e));

      print("statusCode: ${ response.statusCode }");

    } catch(e) {
      print(e);
    }*/

    /*try {
      String url = "${ _PROTOCOL }${ _SERVER }:${ _PORT }/visual-recognition/predict";

      Map<String,String> headers = {
        'Content-type' : 'application/form-data',
      };

      http.MultipartFile multipartFile = await http.MultipartFile.fromBytes('image', file.readAsBytesSync());

      FormData formData = new FormData.fromMap({
        "image": multipartFile,
      });

      final response = await http.post(url, body: formData, headers: headers);

      print('statusCode: ${ response.statusCode }');

    } catch(e) {
      throw new Exception(e);
    }*/

}