import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_dynamic_icons_method_channel.dart';

abstract class FlutterDynamicIconsPlatform extends PlatformInterface {
  /// Constructs a FlutterDynamicIconsPlatform.
  FlutterDynamicIconsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDynamicIconsPlatform _instance =
      MethodChannelFlutterDynamicIcons();

  /// The default instance of [FlutterDynamicIconsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterDynamicIcons].
  static FlutterDynamicIconsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterDynamicIconsPlatform] when
  /// they register themselves.
  static set instance(FlutterDynamicIconsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> supportsAlternateIcons() {
    throw UnimplementedError(
        'supportsAlternateIcons() has not been implemented.');
  }

  Future<String?> getAlternateIconName() {
    throw UnimplementedError(
        'getAlternateIconName() has not been implemented.');
  }

  Future setAlternateIconName(String? iconName) {
    throw UnimplementedError(
        'setAlternateIconName() has not been implemented.');
  }

  Future setIcon(
      {required String icon, required List<String> listAvailableIcon}) {
    throw UnimplementedError('setIcon() has not been implemented.');
  }
}
