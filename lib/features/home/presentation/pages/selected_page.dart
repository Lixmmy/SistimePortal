import 'package:flutter/material.dart';
import 'package:newsistime/features/home/presentation/pages/home_page.dart';
import 'package:newsistime/features/home/presentation/widgets/bnb.dart';
import 'package:newsistime/features/nilai/presentation/pages/nilai_page.dart';
import 'package:newsistime/features/profil/presentation/pages/profil_page.dart';

class SelectedPage extends StatefulWidget {
  const SelectedPage({super.key});

  @override
  State<SelectedPage> createState() => _SelectedPageState();
}

class _SelectedPageState extends State<SelectedPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(), 
    const NilaiPage(),
    const ProfilPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _pages[_selectedIndex],
      bottomNavigationBar: Bnb(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}
