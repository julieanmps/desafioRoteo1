import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _idhash = prefs.getString('ff_idhash') ?? _idhash;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _category = 'Frutas';
  String get category => _category;
  set category(String value) {
    _category = value;
  }

  String _postalcode = '90570020';
  String get postalcode => _postalcode;
  set postalcode(String value) {
    _postalcode = value;
  }

  dynamic _package =
      jsonDecode('{\"height\":4,\"width\":12,\"length\":17,\"weight\":0.3}');
  dynamic get package => _package;
  set package(dynamic value) {
    _package = value;
  }

  List<String> _frete = [];
  List<String> get frete => _frete;
  set frete(List<String> value) {
    _frete = value;
  }

  void addToFrete(String value) {
    frete.add(value);
  }

  void removeFromFrete(String value) {
    frete.remove(value);
  }

  void removeAtIndexFromFrete(int index) {
    frete.removeAt(index);
  }

  void updateFreteAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    frete[index] = updateFn(_frete[index]);
  }

  void insertAtIndexInFrete(int index, String value) {
    frete.insert(index, value);
  }

  int _loop = 0;
  int get loop => _loop;
  set loop(int value) {
    _loop = value;
  }

  double _valorfrete = 0.0;
  double get valorfrete => _valorfrete;
  set valorfrete(double value) {
    _valorfrete = value;
  }

  double _subvalor = 0.0;
  double get subvalor => _subvalor;
  set subvalor(double value) {
    _subvalor = value;
  }

  double _valortotal = 0.0;
  double get valortotal => _valortotal;
  set valortotal(double value) {
    _valortotal = value;
  }

  String _idhash = '';
  String get idhash => _idhash;
  set idhash(String value) {
    _idhash = value;
    prefs.setString('ff_idhash', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
