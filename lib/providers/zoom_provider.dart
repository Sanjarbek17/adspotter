import 'package:flutter/material.dart';

class ZoomProvider with ChangeNotifier{
  double _zoom = 13;
  double get zoom => _zoom;

  void setZoom(double zoom){
    _zoom = zoom;
    notifyListeners();
  }
}