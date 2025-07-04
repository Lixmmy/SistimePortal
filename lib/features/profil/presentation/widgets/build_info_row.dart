import 'package:flutter/material.dart';

class BuildInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const BuildInfoRow( {super.key,required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4, // Adjust flex to control width of label
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            ':',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 6, // Adjust flex to control width of value
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}