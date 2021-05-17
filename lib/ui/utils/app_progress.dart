import 'package:flutter_cell/architecture.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ArcProgress extends StatelessWidget {
  bool isSmall = false;
  bool isLarge = false;
  double size;
  double? padding;
  Color color;

  ArcProgress(this.size, this.padding, {Color? color}) : this.color = color ?? Architecture.instance.colors.accent;

  ArcProgress.large({Color? color, this.size = 55})
      : isLarge = true,
        this.color = color ?? Architecture.instance.colors.accent;

  ArcProgress.small({Color? color, this.size = 22})
      : isSmall = true,
        this.color = color ?? Architecture.instance.colors.accent;

  @override
  Widget build(BuildContext context) {
    if (isSmall)
      return SizedBox(
        height: size,
        width: size,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      );
    else if (isLarge)
      return SizedBox(
        height: size,
        width: size,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(
            strokeWidth: 1,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      );
    else
      return SizedBox(
        height: size,
        width: size,
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0),
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      );
  }
}
