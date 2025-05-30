import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPrimaryBtn2 extends StatelessWidget {
  const CustomPrimaryBtn2(
      {required this.title,
      // required this.validator,
      required this.isLoading,
      required this.onTap});
  final Function()? onTap;
  // var validator;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.ah,
        width: 333.aw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [HexColor('#001649'), HexColor('#000C27')],
          ),
        ),
        child: Center(
          child: isLoading
              ?  SizedBox(
                  height: 34.adaptSize,
                  width: 34.adaptSize,
                  child: const CircularProgressIndicator(strokeWidth: 1,))
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.adaptSize,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: 0.90,
                  ),
                ),
        ),
      ),
    );
  }
}

