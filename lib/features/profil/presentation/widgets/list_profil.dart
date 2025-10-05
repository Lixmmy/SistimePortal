import 'package:flutter/material.dart';
import 'package:newsistime/core/theme/theme.dart';

class ListProfil extends StatelessWidget {
  final String title;
  final String subtitle;

  const ListProfil({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.surfaceLightColorA10
                      : Colors.grey,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
