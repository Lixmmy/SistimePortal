import 'package:flutter/material.dart';
import 'package:newsistime/core/router/router.dart';
import 'package:newsistime/injection.dart';

void main() async{
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: myRouter(),
      debugShowCheckedModeBanner: false,
    );
  }
}
