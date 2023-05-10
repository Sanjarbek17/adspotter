import 'package:adspotter/screens/login_page/login_page.dart';
import 'package:flutter/material.dart';

import 'widgets/style.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
          Container(
            width: 400,
            child: Text(
              'Register',
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
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.04,
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
            height: height * 0.04,
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
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            child: const Text('Already have an account'),
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
