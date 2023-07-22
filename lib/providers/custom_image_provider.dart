// import provider package
import 'package:cross_file/cross_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

// import '../auth/firebase_options.dart';
import '../models/model.dart';

// Image provider
class CustomImageProvider extends ChangeNotifier {
  List<Image1> images = [];
  FirebaseAuth auth;

  CustomImageProvider(this.auth);

  // get all image url from firebase storage
  Future<void> getImages() async {
    ListResult user = await FirebaseStorage.instance.ref().child('user').listAll();
    for (Reference ref in user.items) {
      String url = await ref.getDownloadURL();
      String name = ref.name;
      String author = name.split('+')[0];
      name = name.split('T')[1].split('.jp')[0];
      List<String> coord = name.split('-');
      images.add(Image1(author: author, name: name, imageUrl: url, coord: LatLng(double.parse(coord[0]), double.parse(coord[1]))));
    }
    notifyListeners();
  }

  // FirebaseStorage methods
  Future<void> uploadFile(XFile? file, String? username, Position p1) async {
    if (file == null) {
      throw Exception('No file was selected');
    }
    username ??= 'default';
    // get today's date
    DateTime now = DateTime.now();

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance.ref().child('user').child('$username+${now.month}-${now.day}-${now.hour}T${p1.latitude}-${p1.longitude}.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    try {
      ref.putData(await file.readAsBytes(), metadata);
    } catch (e) {
      throw Exception('File upload failed. Only web platfrom is supported.');
    }
    notifyListeners();
  }
}
