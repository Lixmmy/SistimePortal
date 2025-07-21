import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  'images/logo_stmik.png',
                  width: 30,
                  height: 30,
                ),
              ),
              WidgetSpan(
                child: SizedBox(width: 8), // Spacing between logo and text
              ),
              TextSpan(
                text: 'STMIK',
                style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                  fontWeight: FontWeight.w200,
                ),
              ),
              TextSpan(
                text: ' TIME',
                style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () {})],
      ),
      body: Center(
        child: Text('Konten Halaman Beranda Sebenarnya'),
      ),
    );
  }
}
