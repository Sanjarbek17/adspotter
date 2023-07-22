import 'package:flutter/material.dart';

import '../../../../models/model.dart';

class ImagePage extends StatelessWidget {
  final Image1 image;
  const ImagePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(image.author),
      ),
      body: Center(
        child: Image.network(image.imageUrl),
      ),
    );
  }
}
