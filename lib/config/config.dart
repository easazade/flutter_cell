import 'arc/components/colors.dart';
import 'arc/components/di.dart';
import 'arc/components/logger.dart';
import 'arc/components/logic_connectivity.dart';
import 'arc/components/strings.dart';
import 'arc/components/toasts.dart';

class CellConfig {
  //TODO add save instance state stuff here

  final CellConnectivity? connectivity;
  final CellLogger logger;
  final CellColors colors;
  final CellToasts toasts;
  final CellProviders providers;
  final CellStrings strings;

  CellConfig({
    CellLogger? logger,
    CellColors? colors,
    CellToasts? toasts,
    CellProviders? providers,
    CellStrings? strings,
    CellConnectivity? connectivity,
  })  : this.logger = logger ?? DefaultCellLogger(),
        this.colors = colors ?? DefaultCellColors(),
        this.toasts = toasts ?? DefaultCellToasts(),
        this.providers = providers ?? DefaultCellProviders(),
        this.strings = strings ?? DefaultCellStrings(),
        this.connectivity = connectivity;
}
