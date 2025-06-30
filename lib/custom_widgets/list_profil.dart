
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsistime/custom_widgets/text_customize.dart';

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
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)
            ),
            TextCustomize(
              text: subtitle,
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.normal)
    
            )
          ],
        ),
      ),
    );
  }
}
