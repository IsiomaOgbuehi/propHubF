import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prophub/src/theme/app_colors.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import 'package:prophub/src/widgets/bottons/done_button/keyboard_overlay.dart';

class PropHubTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? initialText;
  final bool? useInitial;
  final String title;
  final Color? color;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final Widget? suffix;
  final bool readOnly;
  final Widget leading;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final double? fieldHeight;
  final double? height;
  final TextAlignVertical? alignVertical;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final ValueNotifier<String?>? validationError;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatter;
  final VoidCallback? downArrowAction;
  final VoidCallback? upArrowAction;
  final Widget? prefix;
  final bool obscureText;
  final String obscuringCharacter;
  final Color cursorColor;

  const PropHubTextField({
    Key? key,
    required this.controller,
    required this.title,
    this.initialText,
    this.useInitial = false,
    this.suffix,
    this.fieldHeight,
    this.height,
    this.alignVertical,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.leading = const SizedBox(
      width: 0,
      height: 0,
    ),
    this.onTap,
    this.validationError,
    this.downArrowAction,
    this.upArrowAction,
    this.onChanged,
    this.inputFormatter,
    this.prefix,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.color,
    this.cursorColor = Colors.white
  }): super(key: key);

  @override
  State<PropHubTextField> createState() => _PropHubTextFieldState();
}

class _PropHubTextFieldState extends State<PropHubTextField> {

  ValueNotifier<EdgeInsets> padding = ValueNotifier(const EdgeInsets.symmetric(vertical: 10, horizontal: 0));
  ValueNotifier<Border> border = ValueNotifier(Border.all(color: Colors.white70));
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      focusNode = widget.focusNode!;
    } else {
      focusNode = FocusNode();
    }

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        padding.value = EdgeInsets.zero;
        border.value = Border.all(
          color: Colors.white // AppColors.primary01.withOpacity(0.3),
        );

        if (Platform.isIOS && !widget.readOnly) {
          KeyboardOverlay.showOverlay(context,
              upButtonPressed: widget.upArrowAction, downButtonPressed: widget.downArrowAction);
        }
      } else {
        border.value = Border.all(color: Colors.white);

        if (widget.controller.text.isNotEmpty) {
          padding.value = EdgeInsets.zero;
        } else {
          padding.value = const EdgeInsets.symmetric(vertical: 10, horizontal: 0);
        }
        if (Platform.isIOS && !widget.readOnly) {
          KeyboardOverlay.removeOverlay();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<EdgeInsets>(
        valueListenable: padding,
        builder: (context, paddingValue, child) {
          return ValueListenableBuilder(
            valueListenable: widget.validationError ?? ValueNotifier<String?>(null),
            builder: (BuildContext context, String? value, Widget? child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder<Border>(
                      valueListenable: border,
                      builder: (context, borderValue, child) {
                        return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: widget.fieldHeight ?? 66,
                            width: width(context) - 40,
                            decoration: BoxDecoration(
                              color: widget.color ?? (value == null ? Theme.of(context).cardColor : chablisRed),
                              borderRadius: BorderRadius.circular(12),
                              border: borderValue,
                            ),
                            padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: widget.height ?? 32.h,
                              child: TextFormField(
                                textAlignVertical: widget.alignVertical ?? TextAlignVertical.center,
                                focusNode: focusNode,
                                controller: widget.controller,
                                cursorColor: widget.cursorColor,
                                obscureText: widget.obscureText,
                                obscuringCharacter: widget.obscuringCharacter,
                                onEditingComplete: widget.onEditingComplete,
                                minLines: widget.minLines,
                                maxLines: widget.maxLines,
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: value == null ? Colors.white : Colors.amber),
                                validator: widget.validator,
                                keyboardType: widget.keyboardType,
                                readOnly: widget.readOnly,
                                onChanged: widget.onChanged,
                                inputFormatters: widget.inputFormatter,
                                onTap: widget.onTap,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: widget.controller.text.isNotEmpty ? EdgeInsets.zero : paddingValue,
                                  alignLabelWithHint: true,
                                  fillColor: widget.color ?? (value == null ? Theme.of(context).cardColor : chablisRed),
                                  filled: true,
                                  prefix: widget.prefix,
                                  suffixIcon: Container(
                                      width: 0,
                                      alignment: const Alignment(0.99, 0.0),
                                      child: value != null
                                          ? const Icon(
                                        Icons.warning_amber_rounded,
                                        color: Colors.amber,
                                      )
                                          : widget.suffix),
                                  labelStyle: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  labelText: widget.title,
                                ),
                              ),
                            ));
                      }),
                  // const SizedBox(
                  //   height: 10.0,
                  // ),
                  value != null
                      ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.sp),
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.amber, fontSize: 12.sp),
                      ))
                      : const SizedBox(),
                ],
              );
            },
          );
        });
  }
}


///[Background TextField]///

class PropHubBackgroundTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? initialText;
  final bool? useInitial;
  final String title;
  final Color? color;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final Widget? suffix;
  final bool readOnly;
  final Widget leading;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final double? fieldHeight;
  final double? height;
  final TextAlignVertical? alignVertical;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final ValueNotifier<String?>? validationError;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatter;
  final VoidCallback? downArrowAction;
  final VoidCallback? upArrowAction;
  final Widget? prefix;
  final bool obscureText;
  final String obscuringCharacter;
  final Color? background;
  final Color? borderColor;
  final String? hintText;

  const PropHubBackgroundTextField({
    Key? key,
    required this.controller,
    required this.title,
    this.initialText,
    this.useInitial = false,
    this.suffix,
    this.fieldHeight,
    this.height,
    this.alignVertical,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.leading = const SizedBox(
      width: 0,
      height: 0,
    ),
    this.onTap,
    this.validationError,
    this.downArrowAction,
    this.upArrowAction,
    this.onChanged,
    this.inputFormatter,
    this.prefix,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.color = Colors.black,
    this.background = Colors.transparent,
    this.borderColor = Colors.black45,
    this.hintText
  }): super(key: key);

  @override
  State<PropHubBackgroundTextField> createState() => _PropHubBackgroundTextFieldState();
}

class _PropHubBackgroundTextFieldState extends State<PropHubBackgroundTextField> {

  ValueNotifier<EdgeInsets> padding = ValueNotifier(const EdgeInsets.symmetric(vertical: 10, horizontal: 0));
  ValueNotifier<Border> border = ValueNotifier(Border.all(color: Colors.white70));
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      focusNode = widget.focusNode!;
    } else {
      focusNode = FocusNode();
    }

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        padding.value = EdgeInsets.zero;
        border.value = Border.all(
            color: widget.borderColor ?? Colors.black // AppColors.primary01.withOpacity(0.3),
        );

        if (Platform.isIOS && !widget.readOnly) {
          KeyboardOverlay.showOverlay(context,
              upButtonPressed: widget.upArrowAction, downButtonPressed: widget.downArrowAction);
        }
      } else {
        border.value = Border.all(color: widget.borderColor ?? Colors.black);

        if (widget.controller.text.isNotEmpty) {
          padding.value = EdgeInsets.zero;
        } else {
          padding.value = const EdgeInsets.symmetric(vertical: 10, horizontal: 0);
        }
        if (Platform.isIOS && !widget.readOnly) {
          KeyboardOverlay.removeOverlay();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<EdgeInsets>(
        valueListenable: padding,
        builder: (context, paddingValue, child) {
          return ValueListenableBuilder(
            valueListenable: widget.validationError ?? ValueNotifier<String?>(null),
            builder: (BuildContext context, String? value, Widget? child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder<Border>(
                      valueListenable: border,
                      builder: (context, borderValue, child) {
                        return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: widget.fieldHeight ?? 66,
                            width: width(context),
                            decoration: BoxDecoration(
                              color: widget.background ?? (value == null ? Theme.of(context).cardColor : chablisRed),
                              borderRadius: BorderRadius.circular(12),
                              border: borderValue,
                            ),
                            padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: widget.height ?? 32.h,
                              child:
                              Row(
                                children: [
                                  widget.prefix ?? const SizedBox.shrink(),
                                  const SizedBox(width: 10.0,),
                                  Flexible(
                                    child: TextFormField(
                                      textAlignVertical: widget.alignVertical ?? TextAlignVertical.center,
                                      focusNode: focusNode,
                                      controller: widget.controller,
                                      cursorColor: defaultBlack,
                                      obscureText: widget.obscureText,
                                      obscuringCharacter: widget.obscuringCharacter,
                                      onEditingComplete: widget.onEditingComplete,
                                      minLines: widget.minLines,
                                      maxLines: widget.maxLines,
                                      style: TextStyle(
                                          fontSize: 15.0.sp,
                                          fontWeight: FontWeight.bold,
                                          color: value == null ? widget.color : Colors.redAccent),
                                      validator: widget.validator,
                                      keyboardType: widget.keyboardType,
                                      readOnly: widget.readOnly,
                                      onChanged: widget.onChanged,
                                      inputFormatters: widget.inputFormatter,
                                      onTap: widget.onTap,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: widget.controller.text.isNotEmpty ? EdgeInsets.zero : paddingValue,
                                          alignLabelWithHint: true,
                                          fillColor: widget.background != null ? Colors.transparent : (value == null ? Theme.of(context).cardColor : chablisRed),
                                          filled: true,
                                          // prefix: widget.prefix,
                                          suffixIcon: Container(
                                              width: 0,
                                              alignment: const Alignment(0.99, 0.0),
                                              child: value != null
                                                  ? const Icon(
                                                Icons.warning_amber_rounded,
                                                color: Colors.redAccent,
                                              )
                                                  : widget.suffix),
                                          labelStyle: TextStyle(
                                            color: widget.color,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                          // labelText: widget.title,
                                          hintText: widget.hintText ?? ''
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ));
                      }),
                  // const SizedBox(
                  //   height: 10.0,
                  // ),
                  value != null
                      ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.sp),
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.redAccent, fontSize: 12.sp),
                      ))
                      : const SizedBox(),
                ],
              );
            },
          );
        });
  }
}