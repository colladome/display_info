// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final dynamic widthPixels;
  final dynamic heightPixels;
  final dynamic yDpi;
  final dynamic xDpi;

  DisplayInfoData({
    required this.widthPixels,
    required this.heightPixels,
    required this.yDpi,
    required this.xDpi,
  });

  DisplayInfoData copyWith({
    dynamic widthPixels,
    dynamic heightPixels,
    dynamic yDpi,
    dynamic xDpi,
  }) {
    return DisplayInfoData(
      widthPixels: widthPixels ?? this.widthPixels,
      heightPixels: heightPixels ?? this.heightPixels,
      yDpi: yDpi ?? this.yDpi,
      xDpi: xDpi ?? this.xDpi,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'widthPixels': widthPixels,
      'heightPixels': heightPixels,
    };
  }

  factory DisplayInfoData.fromMap(Map<dynamic, dynamic> map) {
    return DisplayInfoData(
      widthPixels: map['widthPixels'] as dynamic,
      heightPixels: map['heightPixels'] as dynamic,
      yDpi: map['yDpi'] as dynamic,
      xDpi: map['xDpi'] as dynamic,
    );
  }

  @override
  String toString() =>
      'DisplayInfoData(widthPixels: $widthPixels, heightPixels: $heightPixels, yDpi : $yDpi, xDpi : $xDpi)';
}
