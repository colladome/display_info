import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'display_info_method_channel.dart';

abstract class DisplayInfoPlatform extends PlatformInterface {
  /// Constructs a DisplayInfoPlatform.
  DisplayInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static DisplayInfoPlatform _instance = MethodChannelDisplayInfo();

  /// The default instance of [DisplayInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelDisplayInfo].
  static DisplayInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DisplayInfoPlatform] when
  /// they register themselves.
  static set instance(DisplayInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
