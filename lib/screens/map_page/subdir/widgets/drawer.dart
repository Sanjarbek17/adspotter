// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  double width;
  double height;
  DrawerWidget({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height * 0.25,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CircleAvatar(
                radius: 35,
                child: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
              Text('username'),
              Text('example@gmail.com'),
            ],
          ),
        ),
        ListTile(
          onTap: () {},
          title: const Text('Log out'),
          trailing: const Icon(Icons.logout),
        )
      ],
    );
  }
}
