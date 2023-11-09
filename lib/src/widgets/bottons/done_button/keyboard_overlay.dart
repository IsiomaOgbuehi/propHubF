import 'package:flutter/cupertino.dart';
import 'done_view.dart';

class KeyboardOverlay {
  static OverlayEntry? _overlayEntry;

  static showOverlay(BuildContext context,
      {VoidCallback? upButtonPressed, VoidCallback? downButtonPressed}) {
    if (_overlayEntry != null) {
      return;
    }

    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom,
        right: 0.0,
        left: 0.0,
        child: InputDoneView(
          upButtonPressed: upButtonPressed,
          downButtonPressed: downButtonPressed,
        ),
      );
    });

    overlayState.insert(_overlayEntry!);
  }

  static removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
