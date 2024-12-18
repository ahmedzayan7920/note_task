import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.suffixIcon,
    this.suffixOnPressed,
    this.validator,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.maxLines,
  });
  final String label;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final void Function()? suffixOnPressed;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        counterText: "",
        label: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade700,
              ),
        ),
        labelStyle: TextStyle(
          color: Colors.grey.shade700,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.grey.shade700,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixOnPressed,
                icon: Icon(suffixIcon),
                color: Theme.of(context).colorScheme.onSecondary,
              )
            : null,
        border: buildFieldBorder(color: Colors.grey.shade400),
        disabledBorder: buildFieldBorder(color: Colors.grey.shade300),
        enabledBorder: buildFieldBorder(color: Colors.grey),
        focusedBorder: buildFieldBorder(color: Colors.grey),
        errorBorder: buildFieldBorder(color: Colors.red),
        focusedErrorBorder: buildFieldBorder(color: Colors.red),
      ),
    );
  }

  OutlineInputBorder buildFieldBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: color, width: 2),
    );
  }
}
