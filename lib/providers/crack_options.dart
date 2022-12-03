import 'package:flutter/material.dart';

class CrackOptionsProvider with ChangeNotifier {
  int _hashType = 0;
  int get hashType => _hashType;
  set hashType(value) {
    _hashType = value;
    notifyListeners();
  }

  String _target = ""; // this could be a string with one hash or a path to a .txt file (I think)
  String get target => _target;
  set target(value) {
    _target = value;
    notifyListeners();
  }

  int _attackMode = 0;
  int get attackMode => _attackMode;
  set attackMode(value) {
    _attackMode = value;
    notifyListeners();
  }

  String _dictionary = "";
  String get dictionary => _dictionary;
  set dictionary(value) {
    _dictionary = value;
    notifyListeners();
  }

  List<String> _outfileFormat = [];
  List<String> get outfileFormat => _outfileFormat;
  set outfileFormat(value) {
    _outfileFormat = value;
    notifyListeners();
  }

  String _extraArgs = "";
  String get extraArgs => _extraArgs;
  set extraArgs(value) {
    _extraArgs = value;
    notifyListeners();
  }

  initCrackOptions() {
    _hashType = 0;
    _target = "";
    _attackMode = 0;
    _dictionary = "";
    _outfileFormat = [];
    _extraArgs = "";

    notifyListeners();
  }
}
