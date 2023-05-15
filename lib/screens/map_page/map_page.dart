import 'package:adspotter/screens/map_page/subdir/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import '../../providers/main_provider.dart';
import 'subdir/widgets/map/map.dart';

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
    final image = Provider.of<CustomImageProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(
          height: height,
          width: width,
        ),
      ),
      appBar: AppBar(
        title: const Text('AdSptter'),
      ),
      body: FutureBuilder(
        future: image.getImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            for (var i in image.images) {
              lst.add(
                Marker(
                  width: 50,
                  height: 50,
                  point: i.coord,
                  builder: (context) => Column(
                    children: [
                      Image.network(
                        i.imageUrl,
                      ),
                      Text(i.author),
                    ],
                  ),
                ),
              );
            }
            return Maps(
              lst: lst,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
