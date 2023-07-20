import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dynamic_icons/flutter_dynamic_icons.dart';
import 'package:flutter_dynamic_icons/flutter_dynamic_icons_platform_interface.dart';
import 'package:flutter_dynamic_icons/flutter_dynamic_icons_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDynamicIconsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDynamicIconsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterDynamicIconsPlatform initialPlatform = FlutterDynamicIconsPlatform.instance;

  test('$MethodChannelFlutterDynamicIcons is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDynamicIcons>());
  });

  test('getPlatformVersion', () async {
    FlutterDynamicIcons flutterDynamicIconsPlugin = FlutterDynamicIcons();
    MockFlutterDynamicIconsPlatform fakePlatform = MockFlutterDynamicIconsPlatform();
    FlutterDynamicIconsPlatform.instance = fakePlatform;

    expect(await flutterDynamicIconsPlugin.getPlatformVersion(), '42');
  });
}
