// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class CustomerInfoForm extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final int partySize;
  final String contactPreference;
  final List<String> specialRequests;
  final Map<String, String> validationErrors;

  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onPhoneChanged;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<int> onPartySizeChanged;
  final ValueChanged<String> onContactPreferenceChanged;
  final ValueChanged<String> onSpecialRequestToggled;

  const CustomerInfoForm({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.partySize,
    required this.contactPreference,
    required this.specialRequests,
    required this.validationErrors,
    required this.onNameChanged,
    required this.onPhoneChanged,
    required this.onEmailChanged,
    required this.onPartySizeChanged,
    required this.onContactPreferenceChanged,
    required this.onSpecialRequestToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Row(
            children: [
              const Icon(
                Icons.badge_outlined,
                color: AppColors.primary,
                size: 24.0,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Customer Information',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Divider(color: AppColors.outlineVariant, height: 1.0, thickness: 0.5),
          const SizedBox(height: 20.0),

          // Full Name & Mobile Row
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 500) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildNameField()),
                    const SizedBox(width: 16.0),
                    Expanded(child: _buildPhoneField()),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildNameField(),
                    const SizedBox(height: 16.0),
                    _buildPhoneField(),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 16.0),

          // Email
          _buildEmailField(),
          const SizedBox(height: 20.0),

          // Party Size
          const Text(
            'Party Size',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCounterButton(
                      Icons.remove,
                      partySize > 1 ? () => onPartySizeChanged(partySize - 1) : null,
                    ),
                    const SizedBox(width: 16.0),
                    SizedBox(
                      width: 32.0,
                      child: Text(
                        '$partySize',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    _buildCounterButton(
                      Icons.add,
                      () => onPartySizeChanged(partySize + 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),

          // Contact Preference Selector
          const Text(
            'Preferred Contact Method',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              _buildPreferenceTab('SMS', contactPreference == 'SMS'),
              const SizedBox(width: 8.0),
              _buildPreferenceTab('Email', contactPreference == 'Email'),
              const SizedBox(width: 8.0),
              _buildPreferenceTab('Phone', contactPreference == 'Phone'),
            ],
          ),
          const SizedBox(height: 20.0),

          // Special Requests Selector
          const Text(
            'Special Requests',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _buildChip('Birthday', Icons.cake_rounded),
              _buildChip('Wheelchair', Icons.accessible_rounded),
              _buildChip('Window Seating', Icons.window_rounded),
              _buildChip('Child Seat', Icons.child_care_rounded),
              _buildChip('High Chair', Icons.chair_alt_rounded),
              _buildChip('Quiet Area', Icons.volume_off_rounded),
              _buildChip('VIP Service', Icons.workspace_premium_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    final hasErr = validationErrors.containsKey('customerName');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Full Name',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6.0),
        TextField(
          controller: TextEditingController(text: name)..selection = TextSelection.fromPosition(TextPosition(offset: name.length)),
          onChanged: onNameChanged,
          decoration: InputDecoration(
            hintText: 'e.g. Alexander Pierce',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
            errorText: hasErr ? validationErrors['customerName'] : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: AppColors.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    final hasErr = validationErrors.containsKey('phoneNumber');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mobile Number',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: AppColors.outlineVariant.withOpacity(0.1),
                border: Border.all(color: AppColors.outlineVariant),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
              ),
              child: const Center(
                child: Text(
                  '+1',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: TextEditingController(text: phone)..selection = TextSelection.fromPosition(TextPosition(offset: phone.length)),
                onChanged: onPhoneChanged,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '(555) 000-0000',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  errorText: hasErr ? validationErrors['phoneNumber'] : null,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                    borderSide: BorderSide(color: AppColors.outlineVariant),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                    borderSide: BorderSide(color: AppColors.primary, width: 2.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    final hasErr = validationErrors.containsKey('email');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email (Optional)',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6.0),
        TextField(
          controller: TextEditingController(text: email)..selection = TextSelection.fromPosition(TextPosition(offset: email.length)),
          onChanged: onEmailChanged,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'alex@example.com',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
            errorText: hasErr ? validationErrors['email'] : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: AppColors.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback? onTap) {
    return Container(
      width: 44.0,
      height: 44.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppColors.outlineVariant.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Icon(
            icon,
            color: onTap == null ? Colors.grey : AppColors.primary,
            size: 20.0,
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceTab(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => onContactPreferenceChanged(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(99.0),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outlineVariant,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, IconData icon) {
    final isSelected = specialRequests.contains(label);
    return InkWell(
      onTap: () => onSpecialRequestToggled(label),
      borderRadius: BorderRadius.circular(99.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: AppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(99.0),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.outlineVariant,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryGradientStart.withOpacity(0.2),
                    blurRadius: 6.0,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
              size: 16.0,
            ),
            const SizedBox(width: 6.0),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
