import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/core/Theme/app_theme.dart';

class DefaultTextFormField extends StatefulWidget {
  String hintText;
  String? prefixIcon;
  TextEditingController? controller;
  void Function(String)? onChange;
  String? Function(String?)? validator;
  bool isPass;
  DefaultTextFormField({
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
  @override
     late bool obscurePassword = widget.isPass;
  Widget build(BuildContext context) {

    return TextFormField(
     
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      controller: widget.controller,
      onChanged: widget.onChange,
      obscureText: obscurePassword,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon:
            widget.prefixIcon == null
                ? null
                : SvgPicture.asset(
                  'assets/icons/${widget.prefixIcon}.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
        suffixIcon:
            widget.isPass
                ? IconButton(
                                    onPressed: () {
                          obscurePassword = !obscurePassword;
                    setState(() {
                
                    });
                  },
                  icon: Icon(
                    color: AppTheme.gray,
                    obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  ),

                )
                : null,
      ),
    );
  }
}
