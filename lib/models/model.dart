import 'package:geolocator/geolocator.dart';

class Image {
  String name;
  String imageUrl;
  Position coord;

  Image({required this.name, required this.imageUrl, required this.coord});

  String getCoord() {
    return '${coord.latitude}-${coord.longitude}';
  }
}

class Auth {}
