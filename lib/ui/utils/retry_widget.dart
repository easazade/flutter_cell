import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cell/utils/retry_action.dart';

class RetryWidget extends StatelessWidget {
  final RetryAction action;

  RetryWidget(this.action);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action.tryAgain(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        child: Center(
          child: Icon(
            CupertinoIcons.arrow_clockwise_circle,
            size: 48,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
