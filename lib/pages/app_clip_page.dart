import 'package:app_clip/utils.dart';
import 'package:flutter/material.dart';

class AppClipPage extends StatefulWidget {
  const AppClipPage({super.key});

  @override
  State<AppClipPage> createState() => _AppClipPageState();
}

class _AppClipPageState extends State<AppClipPage> {
  String param = "Empty";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _incomingURLListener();
  }

  _incomingURLListener() async {
    final initialUrl = await UtilsAppClip.getInitialIncomingURL();
    setState(() {
      param = initialUrl ?? 'Empty';
      isLoading = false;
    });
    UtilsAppClip.incomingURLListener((p0) {
      param = p0 ?? 'Empty';
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Clip Page')),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : Text(param),
      ),
    );
  }
}
