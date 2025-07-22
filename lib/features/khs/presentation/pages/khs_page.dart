import 'package:flutter/material.dart';

class KhsPage extends StatelessWidget {
  const KhsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to the KhS Page',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
