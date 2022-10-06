
import 'package:flutter/material.dart';
import 'common/color_schemes.g.dart';
import 'package:firebase_auth_flutter/page/sign_in_page.dart';
import 'package:firebase_auth_flutter/page/sign_up_page.dart';
import 'package:firebase_auth_flutter/page/home_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.system,
      initialRoute: SignInPage.id,
      routes: {
        SignUpPage.id:(context) => const SignUpPage(),
        SignInPage.id:(context) => const SignInPage(),
        HomePage.id:(context) => const HomePage(),
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Update with your UI',
              ),
            ],
          ),
        ),
    );
  }
}