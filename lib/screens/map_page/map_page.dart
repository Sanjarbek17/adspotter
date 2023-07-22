import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../providers/custom_image_provider.dart';
import 'subdir/pages/image_page.dart';
import 'subdir/widgets/drawer.dart';
import 'subdir/widgets/map/map.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final Future<void> getImages;

  @override
  void initState() {
    super.initState();
    final image = Provider.of<CustomImageProvider>(context, listen: false);
    getImages = image.getImages();
  }

  final List<Marker> lst = [];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // ImageProvider
    final image = Provider.of<CustomImageProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(height: height, width: width),
      ),
      appBar: AppBar(
        title: const Text('AdSpotter'),
      ),
      body: FutureBuilder(
        future: getImages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Maps(
                lst: image.images.map((i) {
              return Marker(
                width: 50,
                height: 100,
                point: i.coord,
                builder: (context) => InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePage(image: i)));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(child: Image.network(i.imageUrl, fit: BoxFit.fitWidth, width: 30, height: 30)),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 50,
                        height: 20,
                        child: Text(i.author, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                ),
              );
            }).toList());
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
