import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../providers/custom_image_provider.dart';
import '../../widgets/functions.dart';
import 'camera_page.dart';
import 'image_page.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  double zoom = 13;
  late FollowOnLocationUpdate _followOnLocationUpdate;
  late StreamController<double?> _followCurrentLocationStreamController;
  // late TurnOnHeadingUpdate _turnOnHeadingUpdate;
  late StreamController<void> _turnHeadingUpStreamController;
  late final Future<void> getImages;

  @override
  void initState() {
    super.initState();

    _followOnLocationUpdate = FollowOnLocationUpdate.never;
    // _turnOnHeadingUpdate = TurnOnHeadingUpdate.never;
    _followCurrentLocationStreamController = StreamController<double?>();
    // _turnHeadingUpStreamController = StreamController<void>();
    determinePosition();
    final image = Provider.of<CustomImageProvider>(context, listen: false);
    getImages = image.getImages();
  }

  @override
  void dispose() {
    _followCurrentLocationStreamController.close();
    _turnHeadingUpStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = Provider.of<CustomImageProvider>(context);
    return FlutterMap(
      options: MapOptions(
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        center: LatLng(39.652919301669904, 66.96065624081088),
        zoom: 13,
        maxZoom: 17.5,
        // onMapEvent: (p0) {
        //   if (p0 is MapEventMove) {
        //     print(p0.zoom);
        //     // Provider.of<ZoomProvider>(context, listen: false).setZoom(zoom);
        //   }
        // },
        // onPositionChanged: (position, hasGesture) {
        //   setState(() {
        //     _followOnLocationUpdate = FollowOnLocationUpdate.never;
        //   });
        // },
      ),
      nonRotatedChildren: [
        //camera button
        Positioned(
          right: MediaQuery.of(context).size.width * 0.5 - 30,
          bottom: 40,
          child: ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CameraApp(),
                ),
              );
              // ignore: use_build_context_synchronously
              Provider.of<CustomImageProvider>(context, listen: false).getImages();
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
          // turnHeadingUpLocationStream: _turnHeadingUpStreamController.stream,
          // turnOnHeadingUpdate: _turnOnHeadingUpdate,
        ),
        MarkerLayer(
            markers: image.images.map((i) {
          return Marker(
            width: 70,
            height: 100,
            point: i.coord,
            builder: (context) => InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePage(image: i)));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      image: DecorationImage(image: NetworkImage(i.imageUrl), fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 50,
                    height: 20,
                    child: Text(i.author, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          );
        }).toList()),
      ],
    );
  }
}
