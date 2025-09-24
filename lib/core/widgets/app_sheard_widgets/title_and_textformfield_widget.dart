import 'package:base_project/core/constants/icons_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/core/widgets/other/cutom_text_form_field.dart';
import 'package:base_project/core/widgets/other/image_helper.dart';
import 'package:base_project/core/styles/styles.dart';

/// Base class for all input fields
abstract class BaseInputField extends StatefulWidget {
  final TextEditingController? controller;

  const BaseInputField({super.key, this.controller});

  String get title;
  String get hintText;
  String? Function(String?) get validate;

  /// 🔹 Add this
  void Function(BuildContext, String)? get onChanged => null;

  @override
  State<BaseInputField> createState() => _BaseInputFieldState();
}

class _BaseInputFieldState extends State<BaseInputField> {
  bool isFieldHasError = false;

  void setError(bool value) {
    setState(() {
      isFieldHasError = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        isFieldHasError
            ? Row(
                children: [
                  const ImageHelper(
                    image: IconsPath.errorImage,
                    imageType: ImageType.svg,
                  ),
                  SizedBox(width: 8.w),
                  CustomText(
                    text: widget.title,
                    textStyle: TextStyles.styleTextSMStrong.copyWith(
                      color: ColorManager.errorBorder,
                    ),
                  )
                ],
              )
            : CustomText(
                text: widget.title,
                textStyle: TextStyles.styleTextSMStrong,
              ),
        SizedBox(height: 12.h),
        CustomTextFormField(
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          fillColor: isFieldHasError
              ? ColorManager.errorFill
              : ColorManager.secondaryBackground,
          controller: widget.controller,
          hintText: widget.hintText,
          validationFunc: (value) {
            final result = widget.validate(value);

            // If validation fails, mark error
            setState(() {
              isFieldHasError = result != null;
            });

            return result;
          },
          onChanged: (val) {
            if (widget.onChanged != null) {
              widget.onChanged!(context, val!);
            }
          }, // ✅ added
        ),
      ],
    );
  }
}
