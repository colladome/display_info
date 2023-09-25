import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'display_info_platform_interface.dart';

/// An implementation of [DisplayInfoPlatform] that uses method channels.
class MethodChannelDisplayInfo extends DisplayInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('display_info');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
