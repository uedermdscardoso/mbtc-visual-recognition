
import 'package:mbtc_visual_recognition/stores/visual_recognition/visual_recognition_store.dart';
import 'package:mobx/mobx.dart';

part 'main_store.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {

  final visualRecognition = VisualRecognitionStore();

}

//https://medium.com/flutter-comunidade-br/flutter-com-mobx-c0f4762fbd1a
//flutter packages pub run build_runner build --delete-conflicting-outputs
//flutter packages pub run build_runner clean

//flutter packages get

//flutter clean
//flutter pub get
//flutter packages upgrade