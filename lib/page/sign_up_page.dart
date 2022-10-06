
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  static const String id = 'singup_page';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();

}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
          padding: const EdgeInsets.only(top: 48.0),
          child: Container(
            padding: const EdgeInsets.only(left: 32.0, top: 32.0, right: 32.0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)
                )
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/illustrator_sing_up.svg",
                  height: 240.0,
                  width: 240.0,
                ),
                const SizedBox(height: 32.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      labelText: 'Email'),
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
                const SizedBox(height: 72.0),
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
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        navigator.pop();
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
                    "SIGN UP",
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
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "SIGN IN",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 8.0),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(),
              ],
            ),
          )
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
