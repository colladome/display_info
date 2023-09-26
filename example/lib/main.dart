import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:display_info/display_info.dart';

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

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      final screens = await DisplayInfo.getConnectedDisplays();

      setState(() {
        _platformVersion = screens.toString();
      });

      final display = screens.first;

      final heightPixels = double.parse(display.heightPixels.toString());
      final widthPixels = double.parse(display.widthPixels.toString());
      final densityDpi = double.parse(display.densityDpi.toString());

      var widthInches = widthPixels / densityDpi.toDouble();
      var heightInches = heightPixels / densityDpi.toDouble();

      var screenSizeInches =
          sqrt((widthInches * widthInches) + (heightInches * heightInches));

      dev.log(screenSizeInches.toString());

      dev.log(screens.toString());
    } on PlatformException catch (e) {
      dev.log(e.message!);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('List of Devices $_platformVersion'),
        ),
      ),
    );
  }
}
