import 'package:flutter_cell/ui/utils/retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cell/architecture.dart';
import 'package:flutter_cell/utils/retry_action.dart';

class ActionError {
  RetryAction action;
  late String msg;

  ActionError(this.msg, this.action);

  ActionError.notConnected(this.action) {
    msg = Architecture.instance.strings.noConnection;
  }

  Widget widget() {
    // if (msg == Translations.noConnection)
    return RetryWidget(action);
    // else
    //   return ActionErrorWidget(msg, action);
  }

  @override
  bool operator ==(other) => false;

  @override
  int get hashCode => super.hashCode + this.msg.hashCode + 2;

  @override
  String toString() => 'actionError: $msg';
}
