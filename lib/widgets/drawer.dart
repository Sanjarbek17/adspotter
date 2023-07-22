// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';

class DrawerWidget extends StatelessWidget {
  double width;
  double height;
  DrawerWidget({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: height * 0.25,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  radius: 35,
                  child: Icon(Icons.person, size: 30),
                ),
                Text(auth.currentUser.displayName!, style: const TextStyle(fontSize: 20, color: Colors.white)),
                Text(auth.currentUser.email!, style: const TextStyle(fontSize: 15, color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            onTap: () async {
              print('sign out');
              await auth.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              print('end sign out');
            },
            title: const Text('Log out'),
            trailing: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
