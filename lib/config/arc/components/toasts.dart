import 'package:flutter/material.dart';

abstract class ArcToasts {
  void showSuccessToast(BuildContext context, String msg, {bool lengthLong = true});

  void showInfoToast(BuildContext context, String msg, {bool lengthLong = true});

  void showWarningToast(BuildContext context, String msg, {bool lengthLong = true});
}

class DefaultToasts extends ArcToasts {
  void showSuccessToast(BuildContext context, String msg, {bool lengthLong = true}) {
    throw Exception('Toasts is not set in architecture config');
  }

  void showInfoToast(BuildContext context, String msg, {bool lengthLong = true}) {
    throw Exception('Toasts is not set in architecture config');
  }

  void showWarningToast(BuildContext context, String msg, {bool lengthLong = true}) {
    throw Exception('Toasts is not set in architecture config');
  }
}
