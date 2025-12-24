import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'SUPABASE_URL', obfuscate: true)
  static final String supabaseUrl = _Env.supabaseUrl;

  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  static final String supabaseAnonKey = _Env.supabaseAnonKey;

  @EnviedField(varName: 'REVENUE_CAT_PLAY_STORE', obfuscate: true)
  static final String revenueCatPlayStore = _Env.revenueCatPlayStore;

  @EnviedField(varName: 'REVENUE_CAT_APP_STORE', obfuscate: true)
  static final String revenueCatAppStore = _Env.revenueCatAppStore;
}