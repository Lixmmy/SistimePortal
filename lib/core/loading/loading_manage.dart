// File: utils/loading_manager.dart

import 'package:flutter/material.dart';
import 'package:newsistime/core/loading/loading_screen.dart';

/// A singleton class to manage the loading overlay.
class LoadingManager {
  // --- Singleton Pattern ---
  static final LoadingManager _instance = LoadingManager._internal();

  factory LoadingManager() {
    return _instance;
  }

  LoadingManager._internal();

  OverlayEntry? _overlayEntry;

  void show(BuildContext context) {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (context) {
          return const Stack(
            children: [
              ModalBarrier(
                color: Colors.black54, 
                dismissible: false, 
              ),
              LoadingScreen(),
            ],
          );
        },
      );
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void dismiss() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  bool get isShowing => _overlayEntry != null;
}
