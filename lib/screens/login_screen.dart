// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'map_screen.dart';
import 'pages/register_page.dart';
import '../widgets/style.dart';

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
  void initState() {
    super.initState();
    // check if user is login
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await Provider.of<AuthProvider>(context, listen: false).isLoginFunction()) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MapPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
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
          SizedBox(height: height * 0.02),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
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
                // TODO: show error message
                // do your stuff
                print('email or password is empty');
                return;
              }
              // login user with email and password
              var r = await Provider.of<AuthProvider>(context, listen: false).signInWithEmailAndPassword(emailController.text, passwordController.text);
              if (r == null) {
                // TODO: show error message
                // do your stuff
                print('email or password is wrong');
                return;
              }
              // replace page with map page
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapPage()));
            },
            child: Container(
              width: 300,
              height: 45,
              alignment: Alignment.center,
              child: const Text('Login'),
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
