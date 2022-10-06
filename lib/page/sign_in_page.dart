
import 'package:firebase_auth_flutter/page/home_page.dart';
import 'package:firebase_auth_flutter/page/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  static const String id = 'singin_page';
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 32.0, top: 80.0, right: 32.0),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/illustrator_sing_in.svg",
              height: 300.0,
              width: 300.0,
            ),
            const SizedBox(height: 32.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size(336, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                try {
                  final navigator = Navigator.of(context);
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  navigator.pushReplacementNamed(HomePage.id);
                } catch (e) {
                  final snackbar = SnackBar(content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: const Text(
                "SIGN IN",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(336, 40)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0))),
              ),
              onPressed: () => Navigator.pushNamed(context, SignUpPage.id),
              child: const Text(
                "SIGN UP",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text("Or Sign In With", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 32.0),
            OutlinedButton.icon(
              icon: Image.asset("assets/ic_google_g.png", height: 24, width: 24),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(336, 40)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0))),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('not yet available'),
                  ),
                );
              },
              label: const Text(
                "SIGN IN WITH GOOGLE",
                style: TextStyle(fontSize: 16),
              ),
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

