import 'package:flutter/material.dart';

class CustomMenuProfil extends StatelessWidget {
  const CustomMenuProfil({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
  });
  final String label;
  final void Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 5.0,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
