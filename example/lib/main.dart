import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_dynamic_icons/flutter_dynamic_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterDynamicIconsPlugin = FlutterDynamicIcons();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterDynamicIconsPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<String> list = ["icon_1", "icon_2", "MainActivity"];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            ElevatedButton(
              onPressed: () {
                _flutterDynamicIconsPlugin.setIcon(
                    icon: 'icon_1', listAvailableIcon: list);
              },
              child: const Text('Change icon 1'),
            ),
            ElevatedButton(
              onPressed: () {
                _flutterDynamicIconsPlugin.setIcon(
                    icon: 'icon_2', listAvailableIcon: list);
              },
              child: const Text('Change icon 2'),
            )
          ],
        ),
      ),
    );
  }
}

class IconSelectorWidget extends StatefulWidget {
  const IconSelectorWidget(
      {super.key, required this.flutterDynamicIconsPlugin});

  final FlutterDynamicIcons flutterDynamicIconsPlugin;

  @override
  State<IconSelectorWidget> createState() => _IconSelectorWidgetState();
}

class _IconSelectorWidgetState extends State<IconSelectorWidget> {
  int batchIconNumber = 0;

  String currentIconName = "?";

  bool loading = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.flutterDynamicIconsPlugin.getAlternateIconName().then((v) {
      setState(() {
        currentIconName = v ?? "`primary`";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Current Icon Name: $currentIconName",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.ac_unit),
          label: const Text("Team Fortress"),
          onPressed: () async {
            try {
              var supportsAlternateIcons = await widget
                  .flutterDynamicIconsPlugin
                  .supportsAlternateIcons();
              if (supportsAlternateIcons) {
                await widget.flutterDynamicIconsPlugin
                    .setAlternateIconName("teamfortress");
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("App icon change successful"),
                ));
                widget.flutterDynamicIconsPlugin
                    .getAlternateIconName()
                    .then((v) {
                  setState(() {
                    currentIconName = v ?? "`primary`";
                  });
                });
                return;
              }
            } on PlatformException catch (e) {
              // ignore: avoid_print
              print(e.toString());
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Failed to change app icon"),
              ));
            }
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.ac_unit),
          label: const Text("Photos"),
          onPressed: () async {
            try {
              if (await widget.flutterDynamicIconsPlugin
                  .supportsAlternateIcons()) {
                await widget.flutterDynamicIconsPlugin
                    .setAlternateIconName("photos");
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("App icon change successful"),
                ));
                widget.flutterDynamicIconsPlugin
                    .getAlternateIconName()
                    .then((v) {
                  setState(() {
                    currentIconName = v ?? "`primary`";
                  });
                });
                return;
              }
            } on PlatformException catch (e) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Failed to change app icon"),
              ));
            }
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.ac_unit),
          label: const Text("Chills"),
          onPressed: () async {
            try {
              if (await widget.flutterDynamicIconsPlugin
                  .supportsAlternateIcons()) {
                await widget.flutterDynamicIconsPlugin
                    .setAlternateIconName("chills");
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("App icon change successful"),
                ));
                widget.flutterDynamicIconsPlugin
                    .getAlternateIconName()
                    .then((v) {
                  setState(() {
                    currentIconName = v ?? "`primary`";
                  });
                });
                return;
              }
            } on PlatformException catch (e) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Failed to change app icon"),
              ));
            }
          },
        ),
        const SizedBox(
          height: 28,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.restore_outlined),
          label: const Text("Restore Icon"),
          onPressed: () async {
            try {
              if (await widget.flutterDynamicIconsPlugin
                  .supportsAlternateIcons()) {
                await widget.flutterDynamicIconsPlugin
                    .setAlternateIconName(null);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("App icon restore successful"),
                ));
                widget.flutterDynamicIconsPlugin
                    .getAlternateIconName()
                    .then((v) {
                  setState(() {
                    currentIconName = v ?? "`primary`";
                  });
                });
                return;
              }
            } on PlatformException catch (e) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Failed to change app icon"),
              ));
            }
          },
        ),
      ],
    );
  }
}
