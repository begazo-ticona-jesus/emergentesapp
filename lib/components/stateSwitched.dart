// ignore_for_file: file_names

import 'package:flutter/material.dart';

class StateWitched extends ChangeNotifier {
  bool _isSwitched = false;

  bool get isSwitched => _isSwitched;

  set isSwitched(bool value) {
    _isSwitched = value;
    notifyListeners();
  }
}