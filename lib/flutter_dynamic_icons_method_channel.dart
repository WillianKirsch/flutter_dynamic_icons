import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_dynamic_icons_platform_interface.dart';

/// An implementation of [FlutterDynamicIconsPlatform] that uses method channels.
class MethodChannelFlutterDynamicIcons extends FlutterDynamicIconsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_dynamic_icons');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// Indicate whether the current platform supports dynamic app icons
  @override
  Future<bool> supportsAlternateIcons() async {
    final bool supportsAltIcons =
        await methodChannel.invokeMethod('supportsAlternateIcons');
    return supportsAltIcons;
  }

  /// Fetch the current iconName
  ///
  /// Return null if the current icon is the default icon
  @override
  Future<String?> getAlternateIconName() async {
    final altIconName =
        await methodChannel.invokeMethod<String?>('getAlternateIconName');
    return altIconName;
  }

  /// Set [iconName] as the current icon for the app
  ///
  /// Throw a [PlatformException] with description if
  /// it can't find [iconName] or there's any other error
  @override
  Future setAlternateIconName(String? iconName) async {
    await methodChannel.invokeMethod<String>(
      'setAlternateIconName',
      <String, dynamic>{'iconName': iconName},
    );
  }

  // For Android
  @override
  Future setIcon(
      {required String icon, required List<String> listAvailableIcon}) async {
    Map<String, dynamic> data = {
      'icon': icon,
      'listAvailableIcon': listAvailableIcon
    };
    await methodChannel.invokeMethod('setIcon', data);
  }
}
