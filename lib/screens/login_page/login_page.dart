import 'package:adspotter/screens/login_page/subdir/register_page.dart';
import 'package:flutter/material.dart';

import './widgets/style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          SizedBox(
            width: 400,
            child: Text(
              'Login',
              style: mainTextStyle,
            ),
          ),
          SizedBox(
            height: height * 0.15,
          ),
          Center(
            child: SizedBox(
              width: 400,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Center(
            child: SizedBox(
              width: 400,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
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
            onPressed: () {},
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
