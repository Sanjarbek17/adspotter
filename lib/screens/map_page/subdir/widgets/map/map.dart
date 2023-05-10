import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

import '../../pages/camera_page.dart';
import 'widgets/functions.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late FollowOnLocationUpdate _followOnLocationUpdate;
  late StreamController<double?> _followCurrentLocationStreamController;
  late TurnOnHeadingUpdate _turnOnHeadingUpdate;
  late StreamController<void> _turnHeadingUpStreamController;

  @override
  void initState() {
    super.initState();

    _followOnLocationUpdate = FollowOnLocationUpdate.never;
    _turnOnHeadingUpdate = TurnOnHeadingUpdate.never;
    _followCurrentLocationStreamController = StreamController<double?>();
    _turnHeadingUpStreamController = StreamController<void>();
    determinePosition();
  }

  @override
  void dispose() {
    _followCurrentLocationStreamController.close();
    _turnHeadingUpStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.509364, -0.128928),
          zoom: 9.2,
          onPositionChanged: (position, hasGesture) {
            setState(() {
              _followOnLocationUpdate = FollowOnLocationUpdate.never;
            });
          },
        ),
        nonRotatedChildren: [
          //camera button
          Positioned(
            right: MediaQuery.of(context).size.width * 0.38,
            bottom: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraApp(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.camera, color: Colors.white, size: 45),
              ),
            ),
          ),
          //location button
          Positioned(
            right: 20,
            bottom: 30,
            child: FloatingActionButton(
              onPressed: () {
                // Follow the location marker on the map when location updated until user interact with the map.
                setState(
                  () => _followOnLocationUpdate = FollowOnLocationUpdate.always,
                );
                // Follow the location marker on the map and zoom the map to level 18.
                _followCurrentLocationStreamController.add(18);
                _turnHeadingUpStreamController.add(null);
              },
              child: const Icon(Icons.my_location),
            ),
          )
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          CurrentLocationLayer(
            style: const LocationMarkerStyle(
              marker: DefaultLocationMarker(child: Icon(Icons.navigation, color: Colors.white)),
              markerSize: Size(40, 40),
              markerDirection: MarkerDirection.heading,
            ),
            followCurrentLocationStream: _followCurrentLocationStreamController.stream,
            followOnLocationUpdate: _followOnLocationUpdate,
            turnHeadingUpLocationStream: _turnHeadingUpStreamController.stream,
            turnOnHeadingUpdate: _turnOnHeadingUpdate,
          ),
          MarkerLayer(
            markers: [
              // this is where markers placed
              Marker(
                point: LatLng(51.509364, -0.128928),
                width: 80,
                height: 80,
                builder: (context) => Image.asset(
                  'assets/group.png',
                  fit: BoxFit.fill,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
