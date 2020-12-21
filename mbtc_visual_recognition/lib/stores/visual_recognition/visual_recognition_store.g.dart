// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visual_recognition_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VisualRecognitionStore on _VisualRecognitionStore, Store {
  final _$predictedAtom = Atom(name: '_VisualRecognitionStore.predicted');

  @override
  Future<String> get predicted {
    _$predictedAtom.reportRead();
    return super.predicted;
  }

  @override
  set predicted(Future<String> value) {
    _$predictedAtom.reportWrite(value, super.predicted, () {
      super.predicted = value;
    });
  }

  final _$classifyAsyncAction = AsyncAction('_VisualRecognitionStore.classify');

  @override
  Future classify({File image}) {
    return _$classifyAsyncAction.run(() => super.classify(image: image));
  }

  final _$_VisualRecognitionStoreActionController =
      ActionController(name: '_VisualRecognitionStore');

  @override
  String getName({String result}) {
    final _$actionInfo = _$_VisualRecognitionStoreActionController.startAction(
        name: '_VisualRecognitionStore.getName');
    try {
      return super.getName(result: result);
    } finally {
      _$_VisualRecognitionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
predicted: ${predicted}
    ''';
  }
}
