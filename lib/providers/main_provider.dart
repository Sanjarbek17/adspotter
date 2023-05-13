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
    List<Image1> images = [];
    print('getting images');
    ListResult user = await FirebaseStorage.instance.ref().child('user').listAll();
    print(user.items.length);
    for (Reference ref in user.items) {
      String url = await ref.getDownloadURL();
      print(url);
      String name = ref.name;
      print(name);
      String author = name.split('+')[0];
      print('author: $author');
      name = name.split('T')[1].split('.jp')[0];
      List<String> coord = name.split('-');
      print(coord);
      images.add(Image1(author: author, name: name, imageUrl: url, coord: LatLng(double.parse(coord[0]), double.parse(coord[1]))));
      print('for loop');
    }
    print('end images');
    print(images);
    // notifyListeners();
    return 'done';
  }

  // FirebaseStorage methods
  Future<void> uploadFile(XFile? file, String? username, Position p1) async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAHJL1Fim3nafQYlCVN_d0A9qN1WKdx7NE",
        authDomain: "adpotter-1d5c7.firebaseapp.com",
        projectId: "adpotter-1d5c7",
        storageBucket: "adpotter-1d5c7.appspot.com",
        messagingSenderId: "380741780358",
        appId: "1:380741780358:web:38b676a07fd12b7083a207",
        measurementId: "G-SYJP3CM2LX",
      ),
    );
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
  }
}

// Auth provider
class AuthProvider extends ChangeNotifier {
  // firebase auth instance
  final FirebaseAuth _auth;

  AuthProvider(this._auth);

  // is login
  bool isLogin = false;

  Future<String> initialize() async {
    FirebaseApp app = await Firebase.initializeApp(
      name: 'home',
      options: const FirebaseOptions(
        apiKey: "AIzaSyAHJL1Fim3nafQYlCVN_d0A9qN1WKdx7NE",
        authDomain: "adpotter-1d5c7.firebaseapp.com",
        projectId: "adpotter-1d5c7",
        storageBucket: "adpotter-1d5c7.appspot.com",
        messagingSenderId: "380741780358",
        appId: "1:380741780358:web:38b676a07fd12b7083a207",
        measurementId: "G-SYJP3CM2LX",
      ),
    );

    print('Initialized $app');
    return 'hi';
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      User? user = result.user;
      isLogin = true;
      notifyListeners();
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      await _auth.signOut();
      isLogin = false;
    } catch (e) {
      print(e.toString());
    }
  }

  // getter current user
  User get currentUser {
    return _auth.currentUser!;
  }
}
