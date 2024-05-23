import 'package:dog_picture/app/shared/debouncer/debouncer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLifeCycleObserver extends StatefulWidget {
  const AppLifeCycleObserver({super.key, this.child});
  final Widget? child;

  @override
  State<AppLifeCycleObserver> createState() => _AppLifeCycleObserverState();
}

class _AppLifeCycleObserverState extends State<AppLifeCycleObserver>
    with WidgetsBindingObserver {
  final Debouncer _debouncer = Debouncer(delay: const Duration(seconds: 1));
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _debouncer.call(() {
        if (kDebugMode) {
          print('Lifecycle Resumed');
        }
      });
    } else if (state == AppLifecycleState.paused) {
      _debouncer.call(() {
        if (kDebugMode) {
          print('Lifecycle Paused');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}
