import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/core/Theme/app_theme.dart';

class DefaultTextFormField extends StatefulWidget {
  final String hintText;
  final String? prefixIcon;
  final TextEditingController? controller;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;
  final bool isPass;

  const DefaultTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChange,
    this.prefixIcon,
    this.validator,
    this.isPass = false,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool obscurePassword;

  @override
  void initState() {
    super.initState();
    obscurePassword = widget.isPass;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: AppTheme.white),
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      controller: widget.controller,
      onChanged: widget.onChange,
      obscureText: obscurePassword,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon == null
            ? null
            : SvgPicture.asset(
                'assets/icons/${widget.prefixIcon}.svg',
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
              ),
        suffixIcon: widget.isPass
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppTheme.white,
                ),
              )
            : null,
      ),
    );
  }
}