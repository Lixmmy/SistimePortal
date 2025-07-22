import 'package:flutter/material.dart';

class PamPage extends StatelessWidget {
  const PamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to the PAM Page',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}