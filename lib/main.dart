import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

import 'auth.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We're using the manual installation on non-web platforms since Google sign in plugin doesn't yet support Dart initialization.
  // See related issue: https://github.com/flutter/flutter/issues/96391
  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: "AIzaSyAHJL1Fim3nafQYlCVN_d0A9qN1WKdx7NE",
    authDomain: "adpotter-1d5c7.firebaseapp.com",
    projectId: "adpotter-1d5c7",
    storageBucket: "adpotter-1d5c7.appspot.com",
    messagingSenderId: "380741780358",
    appId: "1:380741780358:web:38b676a07fd12b7083a207",
    measurementId: "G-SYJP3CM2LX",
  );

  // We store the app and auth to make testing with a named instance easier.
  app = await Firebase.initializeApp(options: firebaseOptions);
  auth = FirebaseAuth.instanceFor(app: app);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(auth: auth, app: app),
    );
  }
}
