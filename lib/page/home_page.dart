
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_flutter/page/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _user = FirebaseAuth.instance.currentUser;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Firebase Auth'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 32.0, top: 56.0, right: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              "assets/illustrator_complete.svg",
              height: 300.0,
              width: 300.0,
            ),
            const SizedBox(height: 32.0),
            Text(
              '${_user?.email}',
              style: TextStyle(
                  fontSize: 24, color: Theme.of(context).colorScheme.primary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(336, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                foregroundColor:
                Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
              onPressed: () async {
                final navigator = Navigator.of(context);
                await _auth.signOut();
                navigator.pushReplacementNamed(SignInPage.id);
              },
              child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 16,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

