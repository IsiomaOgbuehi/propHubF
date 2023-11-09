import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';

class PlatformScaffold extends StatelessWidget {
  const PlatformScaffold({
    Key? key,
    this.isLoading,
    this.applyPadding = true,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  }) : super(key: key);
  final ValueNotifier<bool>? isLoading;
  final bool applyPadding;

  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final WidgetBuilder? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: CupertinoScaffold(
          body: Builder(
            builder: (_) => Scaffold(
              extendBody: extendBody,
              extendBodyBehindAppBar: extendBodyBehindAppBar,
              appBar: appBar,
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: applyPadding
                        ? Constants.scaffoldHorizontalPadding
                        : 0.0),
                child: body == null ? null : Builder(builder: body!),
              ),
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation: floatingActionButtonLocation,
              floatingActionButtonAnimator: floatingActionButtonAnimator,
              persistentFooterButtons: persistentFooterButtons,
              persistentFooterAlignment: persistentFooterAlignment,
              drawer: drawer,
              onDrawerChanged: onDrawerChanged,
              endDrawer: endDrawer,
              onEndDrawerChanged: onEndDrawerChanged,
              drawerScrimColor: drawerScrimColor,
              backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
              bottomNavigationBar: bottomNavigationBar,
              bottomSheet: bottomSheet,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
              primary: primary,
              drawerDragStartBehavior: drawerDragStartBehavior,
              drawerEdgeDragWidth: drawerEdgeDragWidth,
              drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
              endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
              restorationId: restorationId,
            ),
          ),
        ),
    );
  }
}
