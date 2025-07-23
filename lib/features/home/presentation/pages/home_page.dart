import 'package:flutter/material.dart';
import 'package:newsistime/custom_widgets/appbarcustom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        isTextRich: true,
        action: [IconButton(icon: const Icon(Icons.logout), onPressed: () {})],
      ),
      body: Center(
        child: Text('Konten Halaman Beranda Sebenarnya'),
      ),
    );
  }
}
