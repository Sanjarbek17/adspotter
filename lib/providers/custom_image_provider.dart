// import provider package
import 'package:cross_file/cross_file.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import '../auth/firebase_options.dart';
import '../models/model.dart';

// Image provider
class CustomImageProvider extends ChangeNotifier {
  List<Image1> images = [];
  FirebaseAuth auth;

  CustomImageProvider(this.auth);

  // get all image url from firebase storage
  Future<String> getImages() async {
    // List<Image1> images = [];
    ListResult user = await FirebaseStorage.instance.ref().child('user').listAll();
    for (Reference ref in user.items) {
      String url = await ref.getDownloadURL();
      String name = ref.name;
      String author = name.split('+')[0];
      name = name.split('T')[1].split('.jp')[0];
      List<String> coord = name.split('-');
      images.add(Image1(author: author, name: name, imageUrl: url, coord: LatLng(double.parse(coord[0]), double.parse(coord[1]))));
    }
    // notifyListeners();
    return 'done';
  }

  // FirebaseStorage methods
  Future<void> uploadFile(XFile? file, String? username, Position p1) async {
    // await Firebase.initializeApp(
    //   options: const FirebaseOptions(
    //     apiKey: "AIzaSyAHJL1Fim3nafQYlCVN_d0A9qN1WKdx7NE",
    //     authDomain: "adpotter-1d5c7.firebaseapp.com",
    //     projectId: "adpotter-1d5c7",
    //     storageBucket: "adpotter-1d5c7.appspot.com",
    //     messagingSenderId: "380741780358",
    //     appId: "1:380741780358:web:38b676a07fd12b7083a207",
    //     measurementId: "G-SYJP3CM2LX",
    //   ),
    // );
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
