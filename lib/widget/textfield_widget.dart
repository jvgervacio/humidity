// ignore_for_file: prefer_initializing_formals, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:humidity/globals.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';

class TextFieldWidget extends StatelessWidget {
  final bool error;
  final bool hide;
  final IconData iconData;
  final String label;
  final TextEditingController controller;
  final Function(String) onChanged;

  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.controller,
    required this.iconData,
    required this.onChanged,
    this.error = false,
    this.hide = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primary = ThemeColor.primary;
    Color errorColor = Colors.redAccent;
    return ScreenUtilInit(
      designSize: const Size(1080, 2280),
      builder: () => TextField(
        controller: controller,
        cursorColor: primary,
        onChanged: onChanged,
        obscureText: hide,
        style: TextStyle(
          color: Colors.white,
          fontSize: 40.sp,
        ),
        decoration: InputDecoration(
          labelText: label,
          errorText: error ? "" : null,
          helperText: "",
          helperStyle: TextStyle(height: 1.h, leadingDistribution: TextLeadingDistribution.even),
          errorStyle: TextStyle(height: 1.h, leadingDistribution: TextLeadingDistribution.even),
          alignLabelWithHint: false,
          labelStyle: TextStyle(color: error ? errorColor : primary),
          focusColor: ThemeColor.primary,
          fillColor: Colors.black26,
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: error ? errorColor : primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: errorColor),
          ),
          prefixIcon: Icon(
            iconData,
            size: 70.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class PasswordTextFieldWidget extends StatefulWidget {
  final bool error;
  final String label;
  final IconData iconData;
  final TextEditingController controller;
  final Function(String) onChanged;

  const PasswordTextFieldWidget({
    Key? key,
    required this.label,
    required this.controller,
    required this.iconData,
    required this.onChanged,
    this.error = false,
  }) : super(key: key);

  @override
  State<PasswordTextFieldWidget> createState() => _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  late bool hideText;
  @override
  void initState() {
    hideText = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color primary = ThemeColor.primary;
    Color errorColor = Colors.redAccent;
    return ScreenUtilInit(
      designSize: const Size(1080, 2280),
      builder: () => TextField(
        controller: widget.controller,
        cursorColor: primary,
        obscureText: hideText,
        onChanged: widget.onChanged,
        style: TextStyle(
          color: Colors.white,
          fontSize: 40.sp,
        ),
        decoration: InputDecoration(
          labelText: widget.label,
          errorText: widget.error ? "" : null,
          helperText: "",
          alignLabelWithHint: false,
          labelStyle: TextStyle(color: widget.error ? errorColor : primary),
          focusColor: ThemeColor.primary,
          fillColor: Colors.black26,
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: widget.error ? errorColor : primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: errorColor),
          ),
          prefixIcon: Icon(
            widget.iconData,
            size: 80.h,
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            icon: Iconify(hideText ? Ph.eye_closed : Ph.eye, color: Colors.white),
            iconSize: 15.sp,
            onPressed: () => setState(() => hideText = !hideText),
          ),
        ),
      ),
    );
  }
}
