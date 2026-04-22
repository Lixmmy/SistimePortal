import 'package:flutter/material.dart';

class BuildInfoRow extends StatelessWidget {
  final String label;
  final String? value;
  final Color labelColor;
  final Color valueColor;
  final bool needColon;
  final int labelFlex;
  final int valueFlex;

  const BuildInfoRow({
    super.key,
    required this.label,
    this.value,
    this.labelFlex = 4,
    this.valueFlex = 6,
    this.needColon = true,
    this.labelColor = Colors.white,
    this.valueColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: labelFlex,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: labelColor),
            ),
          ),
          needColon
              ? Text(
                  ':',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: labelColor),
                )
              : SizedBox.shrink(),
          SizedBox(width: 5),
          Expanded(
            flex: valueFlex,
            child: Text(
              value ?? "",
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: valueColor),
            ),
          ),
        ],
      ),
    );
  }
}
