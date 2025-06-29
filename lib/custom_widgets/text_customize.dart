import 'package:flutter/material.dart';

class TextCustomize extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextStyle? style;
  final TextDirection? textDirection;
  final TextBaseline? textBaseline;
  final TextHeightBehavior? textHeightBehavior;
  final TextAlignVertical? textAlignVertical;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis? textWidthBasis;
  final TextLeadingDistribution? textLeadingDistribution;

  const TextCustomize({
    super.key,
    this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.textDecoration,
    this.overflow,
    this.maxLines,
    this.style,
    this.textDirection,
    this.textBaseline,
    this.textHeightBehavior,
    this.textAlignVertical,
    this.locale,
    this.strutStyle,
    this.textWidthBasis,
    this.textLeadingDistribution,
  });
  

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: style ??
          TextStyle(
            fontSize: fontSize,
            color: color ?? Colors.black,
            fontWeight: fontWeight?? FontWeight.bold,
            decoration: textDecoration,
            textBaseline: textBaseline,
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      textDirection: textDirection,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
