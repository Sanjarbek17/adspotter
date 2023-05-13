import 'package:adspotter/screens/login_page/subdir/register_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/main_provider.dart';
import '../map_page/map_page.dart';
import 'subdir/widgets/style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // email and password text controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          SizedBox(width: 400, child: Text('Login', style: mainTextStyle)),
          SizedBox(height: height * 0.15),
          Center(
            child: SizedBox(
              width: 400,
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email', border: OutlineInputBorder()),
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          Center(
            child: SizedBox(
              width: 400,
              child: TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Password', border: OutlineInputBorder()),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ),
              );
            },
            child: const Text('Create account'),
          ),
          const Spacer(),
          FilledButton(
            onPressed: () async {
              // check if email and password is empty and check if email is valid
              if (emailController.text.isEmpty || passwordController.text.isEmpty || !emailController.text.contains('@')) {
                // do your stuff
                return;
              }
              // login user with email and password
              var r = await Provider.of<AuthProvider>(context, listen: false).signInWithEmailAndPassword(emailController.text, passwordController.text);
              if (r == null) {
                // do your stuff
                return;
              }
              // replace page with map page
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapPage()));
            },
            child: Container(
              width: 300,
              height: 45,
              alignment: Alignment.center,
              child: const Text('Login'),
            ),
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
