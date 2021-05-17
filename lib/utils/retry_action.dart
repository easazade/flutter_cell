import 'package:flutter/material.dart';

class RetryAction {
  VoidCallback? _action;

  RetryAction(this._action);

  VoidCallback? get action => _action;

  void tryAgain() {
    if (_action != null) {
      var holder = _action;
      _action = null;
      holder?.call();
    } else {
      print('WARNING retry action is already consumed and called, you cannot call it a second time');
    }
  }
}
