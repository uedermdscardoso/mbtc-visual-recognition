import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mbtc_visual_recognition/services/visual_recognition/visual_recognition_service.dart';
import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';

part 'visual_recognition_store.g.dart';

class VisualRecognitionStore = _VisualRecognitionStore with _$VisualRecognitionStore;

abstract class _VisualRecognitionStore with Store {

  @observable
  Future<String> predicted = Future.value(null);

  @action
  classify({ File image }) async {
    final visualRecognitionService = VisualRecognitionService();

    predicted = Future.value(null);
    String _predicted = await visualRecognitionService.classify(file: image);
    predicted = Future.value(_predicted);
  }

  @action
  String getName({ String result }) {
    final visualRecognitionService = VisualRecognitionService();

    return visualRecognitionService.getName(result: result);
  }

}