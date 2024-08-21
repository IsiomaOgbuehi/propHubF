import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prophub/src/utilities/custom_toast/pop_message.dart';
import 'package:prophub/src/utilities/widgets/error_message_item.dart';


mixin MPermissionHandler<T extends StatefulWidget> on State<T> {
  Future<void> cameraRequestHandler(Function onPermissionGranted, {bool useMerchantTheme = false}) async {
    final status = await Permission.camera.request();

    switch (status) {
      case PermissionStatus.granted:
        onPermissionGranted();
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        if (!mounted) return;
        context.showMessage(
          title: 'Camera Disabled',
          subtitle: "Allow 'Aku' to access the camera to scan QR code",
          isDismissible: false,
          isRestriction: true,
          type: MessageType.camera,
          onAction: openAppSettings,
          useMerchantTheme: useMerchantTheme,
        );
        break;
    }
  }

  Future<void> mediaLibraryRequestHandler(Function onPermissionGranted, {bool useMerchantTheme = false}) async {
    final status = await Permission.mediaLibrary.request();

    switch (status) {
      case PermissionStatus.granted:
        onPermissionGranted();
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        if (!mounted) return;
        context.showMessage(
          title: 'Hi there ;)',
          subtitle: 'Enable access into your storage',
          useMerchantTheme: useMerchantTheme,
          isDismissible: false,
          isRestriction: true,
          type: MessageType.restriction,
          onAction: openAppSettings,
        );
        break;
    }
  }

  Future<void> notificationsRequestHandler(Function onPermissionGranted, {bool useMerchantTheme = false}) async {
    final status = await Permission.notification.request();

    switch (status) {
      case PermissionStatus.granted:
        onPermissionGranted();
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        if (!mounted) return;
        await openAppSettings();
        break;
    }
  }
}
