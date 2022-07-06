import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pams/utils/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final Widget? title;
  final Function? onclick;
  final bool? isBorder;
  final Color? bgColor;

  const CustomButton(
      {Key? key, this.title, this.isBorder, this.bgColor, this.onclick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onclick!();
      },
      child: Container(
        height: 48.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: isBorder == true
              ? Border.all(width: 1, color: CustomColors.background)
              : null,
          borderRadius: BorderRadius.circular(10.r),
          color: bgColor,
        ),
        child: Center(
          child: title!,
        ),
      ),
    );
  }
}
