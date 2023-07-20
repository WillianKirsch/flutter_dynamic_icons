// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'flutter_dynamic_icons_platform_interface.dart';

class FlutterDynamicIcons {
  Future<String?> getPlatformVersion() {
    return FlutterDynamicIconsPlatform.instance.getPlatformVersion();
  }

  Future<bool> supportsAlternateIcons() {
    return FlutterDynamicIconsPlatform.instance.supportsAlternateIcons();
  }

  Future<String?> getAlternateIconName() {
    return FlutterDynamicIconsPlatform.instance.getAlternateIconName();
  }

  Future setAlternateIconName(String? iconName) {
    return FlutterDynamicIconsPlatform.instance.setAlternateIconName(iconName);
  }

  Future setIcon(
      {required String icon, required List<String> listAvailableIcon}) {
    return FlutterDynamicIconsPlatform.instance
        .setIcon(icon: icon, listAvailableIcon: listAvailableIcon);
  }
}
