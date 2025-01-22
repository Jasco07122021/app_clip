import 'dart:async';
import 'dart:developer';

import 'package:app_clip/pages/app_clip_page.dart';
import 'package:app_clip/pages/unknown_page.dart';
import 'package:app_clip/utils.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final type = await UtilsAppClip.getTargetType();
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
      home: _getHome(),
    );
  }

  Widget _getHome() {
    return switch (type) {
      AppTargetType.runner => const HomePage(),
      AppTargetType.appClip => const AppClipPage(),
      AppTargetType.unknown => const UnknownPage(),
    };
  }
}
