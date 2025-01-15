import 'dart:async';
import 'dart:developer';

import 'package:app_clip/utils.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final type = await Utils.getTargetType();
      runApp(MyApp(type: type));
    },
    (error, stack) => log('Uncaught error: $error'),
  );
}

class MyApp extends StatelessWidget {
  final AppTargetType type;

  const MyApp({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Text(type.name),
        ),
      ),
    );
  }

  Color get backgroundColor {
    return switch (type) {
      AppTargetType.runner => Colors.blue,
      AppTargetType.appClip => Colors.red,
      AppTargetType.unknown => Colors.yellow,
    };
  }
}
