import 'package:flutter/services.dart';

class UtilsAppClip {
  static const _methodChannel = MethodChannel('com.jasco.app/appClip');

  static AppTargetType currentTargetType = AppTargetType.unknown;

  static Future<AppTargetType> getTargetType() async {
    try {
      final targetType = await _methodChannel.invokeMethod<String?>(
        'getTargetType',
      );

      currentTargetType = AppTargetType.fromString(targetType);
      return currentTargetType;
    } catch (e) {
      return AppTargetType.unknown;
    }
  }

  static Future<String?> getInitialIncomingURL() async {
    try {
      return _methodChannel.invokeMethod<String?>('getInitialUrl');
    } catch (e) {
      return null;
    }
  }

  static void incomingURLListener(Function(String?) result) async {
    try {
      _methodChannel.setMethodCallHandler(
        (call) async {
          if (call.method == "handleIncomingURL") {
            result.call(call.arguments.toString());
          } else {
            result.call(null);
          }
        },
      );
    } catch (e) {
      result.call(null);
    }
  }
}

enum AppTargetType {
  runner,
  appClip,
  unknown;

  static AppTargetType fromString(String? value) {
    if (value == null) return AppTargetType.unknown;
    return AppTargetType.values.firstWhere(
      (element) => element.name.toLowerCase() == value.toLowerCase(),
      orElse: () => AppTargetType.unknown,
    );
  }
}
