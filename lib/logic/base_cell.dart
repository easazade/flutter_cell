import 'dart:async';
import 'dart:collection';

import 'package:flutter_cell/config/arc/components/logic_connectivity.dart';
import 'package:flutter_cell/utils/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cell/architecture.dart';
import 'package:flutter_cell/ui/utils/app_progress.dart';
import 'package:flutter_cell/utils/action_error.dart';
import 'package:flutter_cell/utils/retry_action.dart';

import 'cell_state.dart';

abstract class BaseCell extends ChangeNotifier {
  CellState _state;
  Message? _message;
  RetryAction? currentErrorRetryAction;
  String? currentErrorMsg;
  RetryAction? currentNeedsConnectionRetryAction;

  // final ConnectionChecker connectionChecker;
  final List<StreamSubscription> subscriptions = [];
  Queue<RetryAction> retryOnConnectionActions = Queue();

  BaseCell([this._state = CellState.STARTED]) {
    if (Architecture.instance.connectivity != null) {
      subscriptions
          .add(Architecture.instance.connectivity!.watch.listen((status) {
        Architecture.instance.logger.log('CUBIT CONNECTIVITY CHECK ');
        Architecture.instance.logger
            .log('HAS CONNECTION -> ${status != ConnectionStatus.NONE}');
        if (status != ConnectionStatus.NONE &&
            retryOnConnectionActions.isNotEmpty) {
          Architecture.instance.logger.log('RETRYING ACTIONS');
          while (retryOnConnectionActions.isNotEmpty) {
            retryOnConnectionActions.removeLast().tryAgain();
          }
        }
      }));
    }
  }

  String get tag => 'NO-TAG - (override tag)';

  bool get isIdle => _state == CellState.IDLE;

  bool get isOffline => _state == CellState.OFFLINE;

  bool get isIdleOrOffline =>
      _state == CellState.OFFLINE || _state == CellState.IDLE;

  bool get hasNoConnection => _state == CellState.NEEDS_CONNECTION;

  bool get inProgress => _state == CellState.PROGRESS;

  bool get isStarted => _state == CellState.STARTED;

  bool get hasError => _state == CellState.ERROR;

  void update([CellState state = CellState.IDLE]) {
    this._state = state;
    emitChanges();
  }

  void progress() {
    this._state = CellState.PROGRESS;
    emitChanges();
  }

  void offline() {
    this._state = CellState.OFFLINE;
    emitChanges();
  }

  void needsConnection(
      {required VoidCallback retry, bool retryOnConnection = true}) {
    var retryAction = RetryAction(retry);
    if (retryOnConnection) {
      retryOnConnectionActions.addFirst(retryAction);
    }
    currentNeedsConnectionRetryAction = retryAction;
    this._state = CellState.NEEDS_CONNECTION;
    emitChanges();
  }

  void error({required String msg, required VoidCallback retry}) {
    this._state = CellState.ERROR;
    currentErrorMsg = msg;
    currentErrorRetryAction = RetryAction(retry);
    emitChanges();
  }

  void show(Message message) {
    this._message = message;
    emitChanges();
  }

  void displayMessage(BuildContext context) => _message?.show(context);

  Future<bool> hasConnection() async {
    var connectivity = Architecture.instance.connectivity;
    if (connectivity == null) {
      Architecture.instance.logger.log(
          '⚠️⚠️⚠️: LogicConnectivity is not set in ArchitectureConfig, please check your configurations we are\n simply returning true and not checking for connection status');
      return true;
    } else {
      return connectivity.hasConnection();
    }
  }

  Widget toWidget() {
    if (_state == CellState.IDLE || _state == CellState.OFFLINE) {
      throw Exception(
          'toWidget cannot be called when CubeState is IDLE & OFFLINE');
    } else if (_state == CellState.STARTED) {
      return Material(
        color: Architecture.instance.colors.defaultBg,
        child: Container(),
      );
    } else if (_state == CellState.PROGRESS) {
      return Material(
        color: Architecture.instance.colors.defaultBg,
        child: Center(child: ArcProgress.large(color: Colors.blueAccent)),
      );
    } else if (_state == CellState.ERROR) {
      return Material(
        color: Architecture.instance.colors.defaultBg,
        child: Center(
            child: ActionError(currentErrorMsg!, currentErrorRetryAction!)
                .widget()),
      );
    } else if (_state == CellState.NEEDS_CONNECTION) {
      return Material(
        color: Architecture.instance.colors.defaultBg,
        child: Center(
            child: ActionError.notConnected(currentNeedsConnectionRetryAction!)
                .widget()),
      );
    } else
      throw Exception(
          'unknown state - this state of cube cannot be converted to widget');
  }

  void onDispose() {}

  @override
  void dispose() {
    Architecture.instance.logger.log('disposing cube $tag');
    subscriptions.forEach((it) => it.cancel);
    onDispose();
    super.dispose();
  }

  void emitChanges() {
    notifyListeners();
    printCubeState();
  }

  void printCubeState() {
    String stateIcon;
    if (_state == CellState.PROGRESS) {
      stateIcon = '🕓';
    } else if (_state == CellState.IDLE) {
      stateIcon = '✅';
    } else if (_state == CellState.ERROR) {
      stateIcon = '⛔';
    } else if (_state == CellState.OFFLINE) {
      stateIcon = '🔵';
    } else if (_state == CellState.STARTED) {
      stateIcon = '🔥';
    } else if (_state == CellState.NEEDS_CONNECTION) {
      stateIcon = '📡';
    } else {
      stateIcon = '😕';
    }
    var toStringValue = toString();
    var message = '$tag: $stateIcon';
    if (toStringValue.startsWith('Instance of')) {
      message = '$tag: $stateIcon -- implement cube toString to see more data';
    } else {
      message = '$tag: $stateIcon -- $toStringValue';
    }
    Architecture.instance.logger.log(message);
  }
}
