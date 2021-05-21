import 'package:flutter_cell/config/config.dart';

import 'config/arc/components/colors.dart';
import 'config/arc/components/di.dart';
import 'config/arc/components/logger.dart';
import 'config/arc/components/logic_connectivity.dart';
import 'config/arc/components/strings.dart';
import 'config/arc/components/toasts.dart';

class Architecture {
  Architecture._();

  CellConfig config = CellConfig();

  static final Architecture instance = Architecture._();

  CellConnectivity? get connectivity => config.connectivity;

  CellLogger get logger => config.logger;

  CellColors get colors => config.colors;

  CellToasts get toasts => config.toasts;

  CellStrings get strings => config.strings;

  CellProviders get providers => config.providers;
}
