import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../widgets/drawer.dart';
import 'pages/map_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  

  

  final List<Marker> lst = [];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // ImageProvider
    
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(height: height, width: width),
      ),
      appBar: AppBar(
        title: const Text('AdSpotter'),
      ),
      body: const Maps(),
    );
  }
}
