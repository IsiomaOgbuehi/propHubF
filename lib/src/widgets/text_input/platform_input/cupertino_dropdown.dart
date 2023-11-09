
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../theme/app_colors.dart';
import '../../../utilities/constants/app_constants.dart';

class PropCupertinoDropdown extends StatefulWidget {
  final List<String> items;
  final String? hintText;
  final ValueChanged<String?>? onChanged;
  final Color? dropIconColor;
  final Color? backgroundColor;
  final String? dropdownValue;
  final bool withHint;

  const PropCupertinoDropdown({
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
  State<PropCupertinoDropdown> createState() => _PropCupertinoDropdownState();
}

class _PropCupertinoDropdownState extends State<PropCupertinoDropdown> {
  late final ValueNotifier<String?> dropdownValueNotifier = ValueNotifier(widget.dropdownValue);

  @override
  void didUpdateWidget(covariant PropCupertinoDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    dropdownValueNotifier.value = widget.dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.onChanged == null) return;

        dropdownValueNotifier.value = await _showPicker(context, widget.items, dropdownValueNotifier.value);
        widget.onChanged!(dropdownValueNotifier.value);
      },
      child: Container(
        height: 66.h,
        width: width(context) - 40,
        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
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
                              style: TextStyle(
                                fontSize: 12.sp,
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
                            color: paleSkyGrey,
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
              Icon(
                Icons.keyboard_arrow_down,
                size: 24.r,
                color: paleSkyGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _showPicker(BuildContext ctx, List<String> items, String? dropdownValue) async {
    String? dropdownValue1;
    int valueIndex;
    if (dropdownValue == null) {
      valueIndex = -1;
    } else {
      valueIndex = items.indexOf(dropdownValue);
    }
    return await showCupertinoModalBottomSheet(
      context: ctx,
      builder: (_) => CupertinoActionSheet(
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border(
                    bottom: BorderSide(
                      color: paleSkyGrey,
                      width: 0.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CupertinoButton(
                      onPressed: () =>
                          Navigator.pop(context, dropdownValue1 ?? items[valueIndex == -1 ? 0 : valueIndex]),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 5.0,
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: width(ctx),
                height: 200.h,
                child: CupertinoPicker(
                  useMagnifier: false,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: silverGrey.withOpacity(0.2),
                  ),
                  backgroundColor: Colors.white,
                  itemExtent: 50,
                  scrollController: FixedExtentScrollController(initialItem: valueIndex == -1 ? 0 : valueIndex),
                  children: items.map((String value) {
                    return Center(
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 25.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onSelectedItemChanged: (value) {
                    setState(
                          () {
                        dropdownValue1 = items[value];
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
