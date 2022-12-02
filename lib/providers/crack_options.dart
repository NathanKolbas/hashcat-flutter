import 'package:flutter/material.dart';
import 'package:hashcat_dart/hashcat.dart';

class CrackOptionsProvider with ChangeNotifier {
  int hashType = 0;
  String target = ""; // this could be a string with one hash or a path to a .txt file (I think)
  int attackMode = 0;
  String dictionary = "";
  List<String> outfileFormat = [];
  String extraArgs = "";

  initCrackOptions() async {
    try {
      hashType = 0;
      target = "";
      attackMode = 0;
      dictionary = "";
      outfileFormat = [];
      extraArgs = "";
    } finally {
      notifyListeners();
    }
  }

  setOutfileFormat(value) {
    outfileFormat = value;
    notifyListeners();
  }
  setExtraArgs(value) {
    extraArgs = value;
    notifyListeners();
  }
  setDictionary(value) {
    dictionary = value;
    notifyListeners();
  }
  setTarget(value) {
    target = value;
    notifyListeners();
  }
  setHashType(value) {
    hashType = value;
    notifyListeners();
  }
  setAttackMode(value) {
    attackMode = value;
    notifyListeners();
  }
}
