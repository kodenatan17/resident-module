import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'resident_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'initResident',
  preferRelativeImports: true,
  asExtension: true,
)
void setupResidentInjection() {
  getIt.initResident();
}
