import 'package:flutter/material.dart';

class KrsPage extends StatelessWidget {
  const KrsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to the KRS Page',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
