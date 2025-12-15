import 'package:envied/envied.dart';

part 'env_keys.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class EnvKeys {
  @EnviedField(varName: 'SENTRY_DSN', obfuscate: true)
  static final String sentryDsn = _EnvKeys.sentryDsn;
}
