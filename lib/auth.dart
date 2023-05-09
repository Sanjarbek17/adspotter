import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoginPage extends StatefulWidget {
  final FirebaseApp app;
  final FirebaseAuth auth;

  const LoginPage({
    Key? key,
    required this.app,
    required this.auth,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _displayNameController,
            decoration: const InputDecoration(
              labelText: 'username',
            ),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                // print(await widget.auth.signInWithEmailAndPassword(
                //   email: _emailController.text,
                //   password: _passwordController.text,
                // ));
                // check username is provided and corectly formatted

                if (_displayNameController.text.isNotEmpty && RegExp(r'^[a-zA-Z0-9]+$').hasMatch(_displayNameController.text)) {
                  // change current user display name
                  await widget.auth.currentUser!.updateDisplayName(_displayNameController.text);
                } else {
                  // throw exception
                  throw FirebaseAuthException(
                    code: 'ERROR_DISPLAY_NAME',
                    message: 'username is not provided',
                  );
                }
                // logout
                // await widget.auth.signOut();
                // print current user
                print(widget.auth.currentUser);
                ListResult result = await FirebaseStorage.instance.ref().child('user').listAll();
                print(result.items.length);
                result.items.forEach((Reference ref) async {
                  String url = await ref.getDownloadURL();
                  print('Found file: $url');
                });
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.message ?? 'Error'),
                  ),
                );
              }
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
