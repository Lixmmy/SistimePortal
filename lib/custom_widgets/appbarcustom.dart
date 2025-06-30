import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  const AppBarCustom({super.key, this.leading, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title?? Row(
        children: [
           Text('STMIK'),
          Text('TIME')
        ],
      ),
      leading:
          leading ??
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back, size: 40, color: Colors.white),
          ),
    );
  }
}
