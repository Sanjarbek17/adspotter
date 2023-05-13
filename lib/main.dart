import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/map_page/map_page.dart';

import 'providers/main_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
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
  final FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);
  // run with multi provider
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CustomImageProvider(auth)),
      ChangeNotifierProvider(create: (context) => AuthProvider(auth)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapPage(),
    );
  }
}
