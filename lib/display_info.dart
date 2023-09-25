import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';

class DisplayInfo {
  static const MethodChannel _channel = MethodChannel('display_info');

  static Future<List<DisplayInfoData>> getConnectedDisplays() async {
    try {
      final result = await _channel.invokeMethod('getConnectedDisplays');

      log(result.runtimeType.toString());

      List<Object?> displayInfoList = List.from(result);

      List<DisplayInfoData> displayData = displayInfoList.map((info) {
        final data = info as Map;

        return DisplayInfoData.fromMap(data);
      }).toList();
      return displayData;
    } on PlatformException catch (e) {
      throw e.message!; // Handle error gracefully
    }
  }
}

class DisplayInfoData {
  final int displayId;
  final String name;
  final int width;
  final int height;
  final double refreshRate;
  final bool isPrimary;

  DisplayInfoData({
    required this.displayId,
    required this.name,
    required this.width,
    required this.height,
    required this.refreshRate,
    required this.isPrimary,
  });

  factory DisplayInfoData.fromMap(Map<dynamic, dynamic> map) {
    return DisplayInfoData(
      displayId: map['displayId'],
      name: map['name'],
      width: map['width'],
      height: map['height'],
      refreshRate: map['refreshRate'],
      isPrimary: map['isPrimary'],
    );
  }

  @override
  String toString() {
    return 'DisplayInfoData(displayId: $displayId, name: $name, width: $width, height: $height, refreshRate: $refreshRate, isPrimary: $isPrimary)';
  }
}
