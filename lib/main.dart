import 'package:aplikasi_baca/common/navigation.dart';
import 'package:aplikasi_baca/ui/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common/app_routes.dart';
import 'common/styles/theme.dart';
import 'data/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final MaterialTheme materialTheme = MaterialTheme(
      GoogleFonts.loraTextTheme()
    );

    return SafeArea(
      child: MaterialApp(
        title: 'Aplikasi Wisata Kota Magetan',
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorKey: navigatorKey,
        theme: materialTheme.light(),
        darkTheme: materialTheme.dark(),
        initialRoute: LoginPage.routeName,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}