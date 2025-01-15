import 'package:flutter/services.dart';

class Utils {
  static Future<AppTargetType> getTargetType() async {
    const methodChannel = MethodChannel('com.jasco.app/target');

    try {
      final targetType = await methodChannel.invokeMethod<String?>(
        'getTargetType',
      );

      if (targetType == null) return AppTargetType.unknown;

      final appTargetType = AppTargetType.values.firstWhere(
        (element) => element.name.toLowerCase() == targetType.toLowerCase(),
        orElse: () => AppTargetType.unknown,
      );

      return appTargetType;
    } catch (e) {
      return AppTargetType.unknown;
    }
  }
}

enum AppTargetType { runner, appClip, unknown }
