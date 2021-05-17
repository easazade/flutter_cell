import 'package:flutter/material.dart';

abstract class ArcColors {
  Color get accent;

  Color get textLight;

  Color get textMed;

  Color get textDark;

  Color get positiveButton;

  Color get negativeButton;

  Color get defaultBg;
}

class DefaultColors extends ArcColors {
  @override
  Color get accent => Colors.blueAccent;

  @override
  Color get textDark => Colors.black;

  @override
  Color get textLight => Colors.grey;

  @override
  Color get textMed => Colors.grey[200]!;

  @override
  Color get negativeButton => Colors.redAccent;

  @override
  Color get positiveButton => Colors.greenAccent;

  @override
  Color get defaultBg => Colors.white;
}
