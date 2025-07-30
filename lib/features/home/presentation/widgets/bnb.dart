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
    List<Widget> destinations = [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.garage), label: 'Nilai'),
      NavigationDestination(icon: Icon(Icons.people), label: 'Profil'),
    ];

    return ClipRRect(
      borderRadius: BorderRadiusGeometry.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
      child: NavigationBar(
        destinations: destinations,
        selectedIndex: selectedIndex,
        onDestinationSelected: onItemTapped,
        animationDuration: Duration(milliseconds: 1000),
      ),
    );
  }
}
