// ignore_for_file: unused_local_variable, avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../../providers/main_provider.dart';
import '../../map_page.dart';
import '../widgets/map/widgets/functions.dart';

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  late List<CameraDescription> _cameras;

  Future<void> getCamera() async {
    _cameras = await availableCameras();

    if (_cameras.length > 1) {
      controller = CameraController(_cameras[1], ResolutionPreset.max);
    } else {
      controller = CameraController(_cameras[0], ResolutionPreset.max);
    }
    await controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      // setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ImageProvider
    final image = Provider.of<CustomImageProvider>(context);
    // AuthProvider
    final auth = Provider.of<AuthProvider>(context);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('taking picture');
          XFile f = await controller.takePicture();
          controller.pausePreview();
          // get user location
          Position loc = await determinePosition();
          // this is where image will be saved
          await image.uploadFile(f, auth.currentUser.displayName, loc);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MapPage(),
              ));
        },
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder(
          future: getCamera(),
          builder: (context, snapshot) {
            print(snapshot.hasData);
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(controller);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    ));
  }
}
