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
          Spacer(
            flex: 2,
          ),
          Container(
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                  builder: (context) => RegisterPage(),
                ),
              );
            },
            child: Text('Create account'),
          ),
          Spacer(),
          FilledButton(
            onPressed: () {},
            child: Container(
              width: 300,
              height: 45,
              alignment: Alignment.center,
              child: Text('Login'),
            ),
          ),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
