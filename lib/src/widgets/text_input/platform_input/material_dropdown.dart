import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utilities/constants/app_constants.dart';

class PropAndroidDropdown extends StatefulWidget {
  final List<String> items;
  final String? hintText;
  final ValueChanged<String?>? onChanged;
  final Color? dropIconColor;
  final Color? backgroundColor;
  final String? dropdownValue;
  final bool withHint;

  const PropAndroidDropdown({
    Key? key,
    required this.items,
    this.hintText,
    this.onChanged,
    required this.dropdownValue,
    this.dropIconColor,
    this.backgroundColor,
    this.withHint = true,
  })  : assert(!withHint || (withHint && hintText != null), 'hint text shouldn\'t be null if withHint is true'),
        super(key: key);

  @override
  State<PropAndroidDropdown> createState() => _PropAndroidDropdownState();
}

class _PropAndroidDropdownState extends State<PropAndroidDropdown> with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;

  late final ValueNotifier<String?> dropdownValueNotifier = ValueNotifier(widget.dropdownValue);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(covariant PropAndroidDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    dropdownValueNotifier.value = widget.dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          if (widget.onChanged == null) return;

          _toggleDropdown();
        },
        child: Container(
          height: 66.h,
          width: width(context) - 40,
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.withHint)
                        ValueListenableBuilder(
                            valueListenable: dropdownValueNotifier,
                            builder: (context, String? value, child) {
                              if (value == null) {
                                return const SizedBox.shrink();
                              }
                              return Text(
                                widget.hintText!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white54,
                                ),
                                textAlign: TextAlign.start,
                              );
                            }),
                      SizedBox(height: 3.h),
                      ValueListenableBuilder(
                        valueListenable: dropdownValueNotifier,
                        builder: (context, String? value, child) {
                          return Text(
                            value ?? widget.hintText ?? '',
                            style: value == null
                                ? TextStyle(
                              color: Colors.white54,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            )
                                : TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.start,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                RotationTransition(
                  turns: _rotateAnimation,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 24.r,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    var size = renderBox?.size;

    var offset = renderBox?.localToGlobal(Offset.zero);
    var topOffset = offset!.dy + size!.height + 5;
    return OverlayEntry(
      // full screen GestureDetector to register when a
      // user has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        // full screen container to register taps anywhere and close drop down
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: size.width,
                child: CompositedTransformFollower(
                  offset: Offset(0, size.height + 5),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: 5,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(15),
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height - topOffset - 15,
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: widget.items.asMap().entries.map((e) {
                            return InkWell(
                              onTap: () {
                                dropdownValueNotifier.value = e.value;
                                widget.onChanged?.call(e.value);
                                _toggleDropdown();
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: (e.key == 0 || e.key == widget.items.length - 1)
                                      ? null
                                      : const Border.symmetric(horizontal: BorderSide(color: paleSkyGrey, width: 0.2)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                  child: Text(
                                    e.value,
                                    style: AppTextStyles.lg.copyWith(
                                      color: AppColors.neutral08,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry?.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }
}
