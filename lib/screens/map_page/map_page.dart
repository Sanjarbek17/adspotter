import 'package:adspotter/screens/map_page/subdir/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'subdir/widgets/map/map.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('AdSptter'),
      ),
      body: const Maps(),
    );
  }
}
