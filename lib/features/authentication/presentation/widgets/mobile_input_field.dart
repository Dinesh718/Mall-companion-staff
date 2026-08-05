// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class MobileInputField extends StatefulWidget {
  final TextEditingController controller;

  const MobileInputField({
    super.key,
    required this.controller,
  });

  @override
  State<MobileInputField> createState() => _MobileInputFieldState();
}

class _MobileInputFieldState extends State<MobileInputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mobile Number',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8.0),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56.0,
          decoration: BoxDecoration(
            color: _isFocused ? Colors.white : const Color(0xFFF8F9FC),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: _isFocused
                  ? AppColors.primary
                  : AppColors.outlineVariant.withOpacity(0.3),
              width: _isFocused ? 2.0 : 1.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Icon prefix
              const Icon(
                Icons.phone_outlined,
                color: AppColors.outline,
                size: 20.0,
              ),
              const SizedBox(width: 8.0),

              // Country Code Prefix + Divider
              const Text(
                '+91',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                width: 1.0,
                height: 24.0,
                color: AppColors.outlineVariant,
              ),
              const SizedBox(width: 12.0),

              // Input field
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurface,
                    letterSpacing: 2.0,
                  ),
                  decoration: const InputDecoration(
                    hintText: '98765 43210',
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0x66CCC3D9), // outline-variant/70
                      letterSpacing: 0.0,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                    counterText: '',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
