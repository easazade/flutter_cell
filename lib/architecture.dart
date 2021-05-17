import 'package:flutter_cell/config/config.dart';

import 'config/arc/components/colors.dart';
import 'config/arc/components/di.dart';
import 'config/arc/components/logger.dart';
import 'config/arc/components/logic_connectivity.dart';
import 'config/arc/components/strings.dart';
import 'config/arc/components/toasts.dart';

class Architecture {
  Architecture._();

  ArchitectureConfig config = ArchitectureConfig();

  static final Architecture instance = Architecture._();

  ArcConnectivity? get connectivity => config.connectivity;

  ArcLogger get logger => config.logger;

  ArcColors get colors => config.colors;

  ArcToasts get toasts => config.toasts;

  ArcStrings get strings => config.strings;

  ArcProviders get providers => config.providers;
}
