import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  const DottedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const DottedLine(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      lineLength: double.infinity,
      lineThickness: 3,
      dashLength: 4,
      dashColor: Color(0xFFB30205),
      dashGapLength: 3,
      dashGapColor: Colors.transparent,
    );
    ;
  }
}
