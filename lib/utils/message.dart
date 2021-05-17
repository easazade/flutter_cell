import 'dart:io';

import 'package:flutter_cell/architecture.dart';
import 'package:flutter_cell/ui/utils/app_progress.dart';
import 'package:flutter/material.dart';

enum MsgType { WARNING, SUCCESS, INFO, TOAST_ACTION, DIALOG, DIALOG_PROGRESS, DIALOG_ACTION, YES_NO_DIALOG }

class Message {
  MsgType type;
  String? msg;
  String? title;
  String? asset;
  IconData? icon;
  bool dismissible;
  bool lengthLong;
  String? actionText;
  VoidCallback? action;
  String? yesText;
  String? noText;
  VoidCallback? yesAction;
  VoidCallback? noAction;

  Message._(
    this.type,
    this.msg, {
    this.title,
    this.lengthLong = false,
    this.asset,
    this.icon,
    this.dismissible = true,
    this.action,
    this.actionText,
    this.yesText,
    this.noText,
    this.yesAction,
    this.noAction,
  });

  factory Message.success(String msg, {bool lengthLong = false}) => Message._(MsgType.SUCCESS, msg, lengthLong: lengthLong);

  factory Message.warning(String msg, {bool lengthLong = false}) => Message._(MsgType.WARNING, msg, lengthLong: lengthLong);

  factory Message.info(String msg, {bool lengthLong = false}) => Message._(MsgType.INFO, msg, lengthLong: lengthLong);

  factory Message.noConnected() => Message._(MsgType.WARNING, Architecture.instance.strings.noConnection, lengthLong: false);

  factory Message.action(String msg, String actionText, VoidCallback action, {bool lengthLong = true}) =>
      Message._(MsgType.TOAST_ACTION, msg, lengthLong: lengthLong, actionText: actionText, action: action);

  factory Message.dialog(String msg, {String? title, String? asset, IconData? icon, bool dismissible = true}) => Message._(
        MsgType.DIALOG,
        msg,
        title: title,
        lengthLong: false,
        asset: asset,
        icon: icon,
        dismissible: dismissible,
      );

  factory Message.actionDialog(
    String msg,
    String actionText,
    VoidCallback action, {
    String? title,
    String? asset,
    IconData? icon,
    bool dismissible = true,
  }) =>
      Message._(
        MsgType.DIALOG_ACTION,
        msg,
        title: title,
        lengthLong: false,
        asset: asset,
        icon: icon,
        dismissible: dismissible,
        actionText: actionText,
        action: action,
      );

  factory Message.yesNoDialog({
    required msg,
    String? yesText,
    String? noText,
    VoidCallback? yesAction,
    VoidCallback? noAction,
    bool dismissible = true,
  }) =>
      Message._(
        MsgType.YES_NO_DIALOG,
        msg,
        yesText: yesText,
        noText: noText,
        yesAction: yesAction,
        noAction: noAction,
        dismissible: dismissible,
      );

  factory Message.progressDialog({String? title, String? msg, bool dismissible = false}) => Message._(
        MsgType.DIALOG_PROGRESS,
        msg ?? Architecture.instance.strings.pleaseWait + ' ...',
        title: title,
        lengthLong: false,
        dismissible: dismissible,
      );

  void show(BuildContext context) {
    if (Platform.isWindows && (type == MsgType.SUCCESS || type == MsgType.WARNING || type == MsgType.INFO)) {
      var holder = msg;
      msg = null;
      if (holder != null) Architecture.instance.logger.log('WINDOWS TOAST : ' + holder);
    } else if (msg != null) {
      var holder = msg;
      msg = null;
      if (type == MsgType.SUCCESS) {
        Architecture.instance.toasts.showSuccessToast(context, holder!, lengthLong: lengthLong);
      } else if (type == MsgType.WARNING) {
        Architecture.instance.toasts.showWarningToast(context, holder!, lengthLong: lengthLong);
      } else if (type == MsgType.INFO) {
        Architecture.instance.toasts.showInfoToast(context, holder!, lengthLong: lengthLong);
      } else if (type == MsgType.DIALOG) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          showDialog(
            barrierDismissible: dismissible,
            context: context,
            builder: (context) => AlertDialog(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 18),
                    if (asset != null) ...[
                      Image.asset(asset!, width: 60),
                      SizedBox(height: 12),
                    ],
                    if (icon != null && asset == null) ...[
                      Icon(icon, size: 60, color: Architecture.instance.colors.accent),
                      SizedBox(height: 12),
                    ],
                    if (title != null) ...[
                      Text(title!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Architecture.instance.colors.textDark)),
                      SizedBox(height: 3),
                    ],
                    Text(holder!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Architecture.instance.colors.textLight)),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        });
      } else if (type == MsgType.DIALOG_PROGRESS) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          showDialog(
            barrierDismissible: dismissible,
            context: context,
            builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      if (title != null) ...[
                        Text(title!,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Architecture.instance.colors.textDark)),
                        SizedBox(height: 10),
                      ],
                      if (holder != null) ...[
                        Text(holder, textAlign: TextAlign.center, style: TextStyle(color: Architecture.instance.colors.textMed)),
                        SizedBox(height: 10),
                      ],
                      ArcProgress.large(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      } else if (type == MsgType.DIALOG_ACTION) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          showDialog(
            barrierDismissible: dismissible,
            context: context,
            builder: (context) => AlertDialog(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 18),
                    if (asset != null) ...[
                      Image.asset(asset!, width: 60),
                      SizedBox(height: 12),
                    ],
                    if (icon != null && asset == null) ...[
                      Icon(icon, size: 60, color: Architecture.instance.colors.accent),
                      SizedBox(height: 12),
                    ],
                    if (title != null) ...[
                      Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Architecture.instance.colors.textDark),
                      ),
                      SizedBox(height: 3),
                    ],
                    Text(
                      holder!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Architecture.instance.colors.textMed),
                    ),
                    SizedBox(height: 15),
                    if (action != null && actionText != null)
                      FlatButton(
                        onPressed: action,
                        child: Text(actionText!, style: TextStyle(color: Colors.white)),
                        color: Architecture.instance.colors.accent,
                      ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        });
      } else if (type == MsgType.YES_NO_DIALOG) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          showDialog(
            barrierDismissible: dismissible,
            context: context,
            builder: (context) => AlertDialog(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 18),
                    Text(holder!,
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Architecture.instance.colors.textMed)),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: Text(yesText ?? 'yes'),
                          onPressed: yesAction ?? Navigator.of(context).pop,
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Architecture.instance.colors.positiveButton),
                          ),
                        ),
                        TextButton(
                          child: Text(noText ?? 'no'),
                          onPressed: noAction ?? Navigator.of(context).pop,
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Architecture.instance.colors.negativeButton),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        });
      }
    }
  }

  @override
  bool operator ==(other) {
    if (other is Message) {
      return this.msg == other.msg;
    } else
      return false;
  }

  @override
  int get hashCode => super.hashCode + this.msg.hashCode + 2;

  @override
  String toString() => 'message: $msg';
}
