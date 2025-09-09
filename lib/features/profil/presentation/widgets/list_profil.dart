
import 'package:flutter/material.dart';
import '../../../../custom_widgets/text_customize.dart';

class ListProfil extends StatelessWidget {

  final String title;
  final String subtitle;

  const ListProfil({
    super.key, required this.title, required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextCustomize(
              text: title,
              style: Theme.of(context).textTheme.titleSmall
            ),
            const SizedBox(width: 5),
            Flexible(
              child: TextCustomize(
                text: subtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey
                ),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
      ),
    );
  }
}
