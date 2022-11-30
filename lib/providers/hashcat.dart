import 'package:flutter/material.dart';
import 'package:hashcat_dart/hashcat.dart';

class HashcatProvider with ChangeNotifier {
  final Hashcat _hashcat = Hashcat();
  bool initError = false;
  bool initialized = false;

  Hashcat get hashcat => _hashcat;

  initHashcat() async {
    try {
      initError = true;
      _hashcat.init();
      initError = false;
      initialized = true;
    } finally {
      notifyListeners();
    }
  }
}
