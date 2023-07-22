import 'package:adspotter/auth/firebase_options.dart';
import 'package:adspotter/providers/auth_provider.dart';
import 'package:adspotter/providers/zoom_provider.dart';
import 'package:adspotter/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'screens/map_page/map_page.dart';

import 'providers/custom_image_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);
  // run with multi provider
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CustomImageProvider(auth)),
      ChangeNotifierProvider(create: (context) => AuthProvider(auth)),
      ChangeNotifierProvider(create: (context) => ZoomProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdSpotter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
