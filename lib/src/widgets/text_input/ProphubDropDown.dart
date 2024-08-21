import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import 'package:prophub/src/widgets/text_input/platform_input/cupertino_dropdown.dart';
import 'package:prophub/src/widgets/text_input/platform_input/material_dropdown.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class FormCustomDropdownField extends FormField<String?> {
  final List<String> items;
  final ValueChanged<String>? onChanged;
  final Color dropIconColor;
  final Color? backgroundColor;
  final String? hintText;
  final DropdownFieldController? controller;
  final bool withHint;
  final bool readOnly;
  final VoidCallback? onEditingComplete;

  FormCustomDropdownField({
    super.key,
    required this.items,
    this.onChanged,
    this.dropIconColor = paleSkyGrey,
    super.validator,
    super.autovalidateMode,
    super.initialValue,
    this.backgroundColor,
    this.hintText,
    this.controller,
    this.withHint = true,
    this.readOnly = false,
    this.onEditingComplete,
  }) : super(
    builder: (state) => Builder(
      builder: (context) {
        return CustomDropDownButton(
          items: items,
          dropdownValue: controller ?? DropdownFieldController(text: state.value),
          onChanged: (value) {
            if (readOnly) return;

            if (value == null || value.isEmpty) return;
            state.didChange(value);
            onChanged?.call(value);

            Future.delayed(
              Constants.shortAnimationDuration,
              onEditingComplete,
            );
          },
          dropIconColor: dropIconColor,
          backGroundColor: backgroundColor,
          hintText: hintText,
          withHint: withHint,
          validationError: ValueNotifier(state.errorText),
        );
      },
    ),
  );
}

class CustomDropDownButton extends StatelessWidget {
  final ValueNotifier<String?> dropdownValue;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final Color dropIconColor;
  final Color? backGroundColor;
  final String? hintText;
  final bool withHint;
  final ValueNotifier<String?>? validationError;

  const CustomDropDownButton({
    Key? key,
    required this.items,
    this.onChanged,
    required this.dropdownValue,
    this.hintText,
    this.dropIconColor = paleSkyGrey,
    this.backGroundColor,
    this.withHint = true,
    this.validationError,
  })  : assert(!withHint || (withHint && hintText != null), 'hint text shouldn\'t be null if withHint is true'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: validationError ?? ValueNotifier<String?>(null),
      builder: (__, String? error, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: error != null ? AppColors.primary03 : Colors.white70, width: 1),
              ),
              position: DecorationPosition.foreground,
              child: Platform.isIOS
                  ? PropCupertinoDropdown(
                items: items,
                hintText: hintText,
                withHint: withHint,
                dropdownValue: dropdownValue.value,
                onChanged: onChanged,
                dropIconColor: dropIconColor,
                backgroundColor: backGroundColor,
              )
                  : PropAndroidDropdown(
                items: items,
                hintText: hintText,
                withHint: withHint,
                dropdownValue: dropdownValue.value,
                onChanged: onChanged,
                dropIconColor: dropIconColor,
                backgroundColor: backGroundColor,
              ),
            ),
            if (error != null) const SizedBox(height: 8),
            if (error != null)
              Text(
                error,
                style: AppTextStyles.md.copyWith(
                  color: AppColors.primary03,
                ),
              ),
          ],
        );
      },
    );
  }
}

class DropdownFieldController extends ValueNotifier<String?> {
  DropdownFieldController({String? text}) : super(text);

  String get text => value ?? '';

  set text(String newText) {
    value = newText;
  }
}