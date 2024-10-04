import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neighborgood_assignment/utils/color/const_color.dart';
import 'package:neighborgood_assignment/utils/fontstyle/const_textStyle.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool obSecure;
  final bool readOnly;
  final bool required;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final int borderRadius;
  List<TextInputFormatter>? inputFormatters = [];

  CustomTextfield({
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obSecure  = false,
    this.required  = true,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    this.hintText,
    this.suffixIcon,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.inputFormatters,
    this.onFieldSubmitted, this.borderRadius = 12,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null ? Padding(
          padding: EdgeInsets.only(bottom: .005.sh),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: ConstFontStyle.textTitle1,
              children: <TextSpan>[
                TextSpan(
                  text:  widget.labelText!,
                  style: ConstFontStyle.textTitle1,
                ),
                TextSpan(
                  text: '*',
                  style: ConstFontStyle.primaryTextStyle1,
                ),
              ],
            ),
          ),
        ) : SizedBox.shrink(),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: false,
          focusNode: focusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingCompleted,
          obscureText: widget.obSecure,
          minLines: widget.isMulti ? 4 : 1,
          maxLines: widget.isMulti ? null : 1,
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0.005.sh,horizontal: 0.02.sw ),
            enabledBorder:OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius.r)),
                borderSide: BorderSide(color: ConstColor.textFieldBorderColor)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius.r)),
                borderSide: BorderSide(color: ConstColor.textFieldBorderColor)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius.r)),
                borderSide: BorderSide(color: ConstColor.textFieldBorderColor)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius.r)),
                borderSide: BorderSide(color: ConstColor.textFieldBorderColor)
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius.r)),
                borderSide: BorderSide(color: ConstColor.textFieldBorderColor)
            ),
            errorMaxLines: 2,
            hintText: widget.hintText,
            hintStyle: ConstFontStyle.hintTextStyle,
            errorText: widget.errorText,
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffixIcon,
            // prefix:  widget.prefix,
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}

