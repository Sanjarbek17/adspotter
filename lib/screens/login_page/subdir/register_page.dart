import 'package:adspotter/providers/main_provider.dart';
import 'package:adspotter/screens/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/style.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // get auth provider
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    // ignore: unused_local_variable
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
                controller: usernameController,
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
                controller: emailController,
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
                controller: passwordController,
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
            onPressed: () async {
              // check if username is empty or email is empty or password is empty
              if (usernameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
                // do something
                return;
              }
              // check if email is valid
              if (!emailController.text.contains('@')) {
                // do something
                return;
              }
              // register user
              var r = await authProvider.registerWithEmailAndPassword(
                emailController.text,
                passwordController.text,
                usernameController.text,
              );
              // check if register was successful
              if (r != 'done') {
                // do something
                // ignore: avoid_print
                print(r);
                return;
              }
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
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
