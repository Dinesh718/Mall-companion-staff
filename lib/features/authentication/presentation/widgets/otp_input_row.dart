// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/themes/app_colors.dart';

class OtpInputRow extends StatefulWidget {
  final List<TextEditingController> controllers;
  final ValueChanged<String> onOtpChanged;

  const OtpInputRow({
    super.key,
    required this.controllers,
    required this.onOtpChanged,
  });

  @override
  State<OtpInputRow> createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<OtpInputRow> {
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
    _triggerOtpCallback();
  }

  void _triggerOtpCallback() {
    final otp = widget.controllers.map((c) => c.text).join();
    widget.onOtpChanged(otp);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;
    final boxSize = isSmall ? 44.0 : 48.0;
    final boxHeight = isSmall ? 52.0 : 56.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: boxSize,
          height: boxHeight,
          child: RawKeyboardListener(
            focusNode: FocusNode(), // Dummy focus node to capture key events
            onKey: (event) {
              if (event is RawKeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace) {
                if (widget.controllers[index].text.isEmpty && index > 0) {
                  widget.controllers[index - 1].clear();
                  _focusNodes[index - 1].requestFocus();
                  _triggerOtpCallback();
                }
              }
            },
            child: TextField(
              controller: widget.controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              autofocus: index == 0,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                counterText: '',
                fillColor: AppColors.surfaceContainer,
                filled: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: AppColors.primaryContainer,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) => _onTextChanged(value, index),
            ),
          ),
        );
      }),
    );
  }
}
