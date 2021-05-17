import 'arc/components/colors.dart';
import 'arc/components/di.dart';
import 'arc/components/logger.dart';
import 'arc/components/logic_connectivity.dart';
import 'arc/components/strings.dart';
import 'arc/components/toasts.dart';

class ArchitectureConfig {
  //TODO add save instance state stuff here

  final ArcConnectivity? connectivity;
  final ArcLogger logger;
  final ArcColors colors;
  final ArcToasts toasts;
  final ArcProviders providers;
  final ArcStrings strings;

  ArchitectureConfig({
    ArcLogger? logger,
    ArcColors? colors,
    ArcToasts? toasts,
    ArcProviders? providers,
    ArcStrings? strings,
    ArcConnectivity? connectivity,
  })  : this.logger = logger ?? DefaultLogger(),
        this.colors = colors ?? DefaultColors(),
        this.toasts = toasts ?? DefaultToasts(),
        this.providers = providers ?? DefaultProviders(),
        this.strings = strings ?? DefaultStrings(),
        this.connectivity = connectivity;


}
