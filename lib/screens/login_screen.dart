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

  String? errorEmail;
  String? errorPassword;

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
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 400, child: Text('Login', style: mainTextStyle)),
                  SizedBox(height: height * 0.15),
                  SizedBox(
                    width: 400,
                    // TITLE: Email input
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: const OutlineInputBorder(),
                        errorText: errorEmail,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  SizedBox(
                    width: 400,
                    // TITLE: password input
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: const OutlineInputBorder(),
                        errorText: errorPassword,
                        // errorStyle: TextStyle
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
                  FilledButton(
                    onPressed: () async {
                      // check if email and password is empty and check if email is valid
                      if (emailController.text.isEmpty) {
                        setState(() {
                          errorEmail = 'email is required';
                        });
                        return;
                      } else {
                        errorEmail = null;
                      }
                      if (!emailController.text.contains('@')) {
                        setState(() {
                          errorEmail = 'Provide vaild email';
                        });
                        return;
                      } else {
                        errorEmail = null;
                      }
                      if (passwordController.text.isEmpty) {
                        setState(() {
                          errorPassword = 'password is required';
                        });
                        return;
                      } else {
                        errorEmail = null;
                      }
                      if (passwordController.text.length < 6) {
                        setState(() {
                          errorPassword = 'password must at least 6 length';
                        });
                        return;
                      } else {
                        errorEmail = null;
                      }
                      // login user with email and password
                      var r = await Provider.of<AuthProvider>(context, listen: false).signInWithEmailAndPassword(emailController.text, passwordController.text);
                      if (r == null) {
                        setState(() {
                          errorEmail = 'email or password is wrong'; 
                        });
                        return;
                      } else {
                        errorEmail = null;
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
