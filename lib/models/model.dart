import 'package:latlong2/latlong.dart';

class Image1 {
  String author;
  String name;
  String imageUrl;
  LatLng coord;

  Image1({required this.author, required this.name, required this.imageUrl, required this.coord});

  String getCoord() {
    return '${coord.latitude}-${coord.longitude}';
  }
}
