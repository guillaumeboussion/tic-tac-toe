import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    this.controller,
    this.focusNode,
    this.errorText,
    this.autofocus = false,
    this.enabled = true,
    this.isDense = false,
    this.initialValue,
    this.hintText,
    this.maxLines = 1,
    this.minLines,
    this.autocorrect = true,
    this.obscureText = false,
    this.keyboardType,
    this.readOnly = false,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.contentPadding,
    this.inputFormatters,
    this.textStyle,
    this.suffixIconTapped,
    this.prefixIconTapped,
    this.onTap,
    this.fillColor,
    this.onChanged,
    this.validator,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? errorText;
  final String? initialValue;
  final bool autofocus;
  final bool enabled;
  final bool isDense;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool readOnly;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? textStyle;
  final void Function()? suffixIconTapped;
  final void Function()? prefixIconTapped;
  final void Function()? onTap;
  final Color? fillColor;
  final int? minLines;
  final int? maxLines;
  final bool autocorrect;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return TextFormField(
      onTap: onTap,
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      initialValue: initialValue,
      autofocus: autofocus,
      enabled: enabled,
      onChanged: onChanged,
      obscureText: obscureText,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      autocorrect: autocorrect,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
      style:
          textStyle ??
          theme.typography.page.inputText.copyWith(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        isDense: isDense,
        filled: fillColor != null,
        fillColor: fillColor,
        contentPadding: contentPadding,
        hintStyle: theme.typography.page.inputText.copyWith(
          color: theme.colors.inputText,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colors.primaryColor),
          borderRadius: theme.radius.regular.asBorderRadius,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colors.inputBorder),
          borderRadius: theme.radius.regular.asBorderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colors.inputBorder),
          borderRadius: theme.radius.regular.asBorderRadius,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colors.inputBorder),
          borderRadius: theme.radius.regular.asBorderRadius,
        ),
      ),
    );
  }
}
