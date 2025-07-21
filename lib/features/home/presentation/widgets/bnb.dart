// presentation/app_shell/widgets/custom_bottom_nav_bar.dart
import 'package:flutter/material.dart';

class Bnb extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const Bnb({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    // List untuk konfigurasi BottomNavigationBarItem
    final List<BottomNavigationBarItem> navItems = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.grade),
      //   label: 'Nilai',
      // ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.upload),
      //   label: 'Upload',
      // ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profil',
      ),
    ];

    return BottomNavigationBar(
      items: navItems,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped, // Callback yang diteruskan ke parent
      type: BottomNavigationBarType.fixed,
    );
  }
}