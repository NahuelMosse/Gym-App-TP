import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final double? height;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    this.height = 56,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.textSecondary,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: height != null ? (height! - 24) / 2 : 16,
        ),
        isDense: false,
        prefixIcon: prefixIcon != null 
          ? Icon(prefixIcon, color: AppColors.inputIcon) 
          : null,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.inputBorder,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error, 
            width: 2,
          ),
        ),
        filled: true,
        fillColor: AppColors.surface,
      ),
    );
  }
}