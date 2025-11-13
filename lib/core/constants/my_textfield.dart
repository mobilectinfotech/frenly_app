import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPrimaryBtn1 extends StatelessWidget {
  const CustomPrimaryBtn1(
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
       // width: Get.width,
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

SizedBox primaryTextfield1({
  required String hintText,
  required controller,
  var validator,
  int? maxLines,
  String? suffixIconn,
  bool? obscureText,
  VoidCallback? onTap,
  Function(String)? onChanged,
  TextInputType? textInputType,
  bool? enabled,
  String? initialValue,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
}) {
  return SizedBox(
    height: 44.ah,
    child: TextFormField(
      onChanged: onChanged,
      cursorColor: HexColor('#655BEF'),
      enabled: enabled ?? true,
      // onTap: onTap,
      maxLength: maxLength,
      initialValue: initialValue,
      keyboardType: textInputType ?? TextInputType.multiline,
      style: const TextStyle(color: Colors.black),
      inputFormatters: inputFormatters ?? null, //
      // Apply the custom formatter
      maxLines: maxLines ?? 1,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,

      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.only(left: 10.h),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(.25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#B5B5B5'),
            width: 1.aw,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#B5B5B5'),
            width: 1,
          ),
        ),
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.aw,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Color(0xff001649),
            width: 1.aw,
          ),
        ),

        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black.withOpacity(.40),
            fontWeight: FontWeight.bold,
            fontSize: 12.fSize),
        suffixIcon: suffixIconn == null
            ? SizedBox(
                height: 1.ah,
                width: 1.aw,
              )
            : IconButton(
                onPressed: onTap,
                icon: SvgPicture.asset(
                  suffixIconn,
                  fit: BoxFit.none,
                  color: Colors.black54,
                ),
              ),
      ),

      obscureText: obscureText ?? false,
      // validator: validator,
    ),
  );
}

SizedBox primaryTextfield2({
  required String hintText,
  required controller,
  var validator,
  int? maxLines,
  String? suffixIconn,
  bool? obscureText,
  VoidCallback? onTap,
  TextInputType? textInputType,
  bool? enabled,
  String? initialValue,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
}) {
  return SizedBox(
    height: 50.ah,
    child: TextFormField(
      cursorColor: Colors.black,
      enabled: enabled ?? true,
      // onTap: onTap,

      maxLength: maxLength,
      initialValue: initialValue,
      keyboardType: textInputType ?? TextInputType.multiline,
      style: TextStyle(
          color: Colors.black, fontSize: 15.fSize, fontWeight: FontWeight.w500),
      inputFormatters: inputFormatters ?? null, //
      // Apply the custom formatter
      maxLines: maxLines ?? 1,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,

      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.only(left: 20),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(.25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),

        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
        suffixIcon: suffixIconn == null
            ? const SizedBox(
                height: 1,
                width: 1,
              )
            : IconButton(
                onPressed: onTap,
                icon: SvgPicture.asset(
                  suffixIconn,
                  fit: BoxFit.none,
                  color: Colors.black,
                ),
              ),
      ),

      obscureText: obscureText ?? false,
      // validator: validator,
    ),
  );
}

SizedBox primaryTextfield3({
  required String hintText,
  required controller,
  var validator,
  int? maxLines,
  String? suffixIconn,
  bool? obscureText,
  VoidCallback? onTap,
  TextInputType? textInputType,
  bool? enabled,
  String? initialValue,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
}) {
  return SizedBox(
    height: 60.ah,
    child: TextFormField(
      cursorColor: Colors.black,
      enabled: enabled ?? true,
      // onTap: onTap,

      maxLength: maxLines,
      initialValue: initialValue,
      keyboardType: textInputType ?? TextInputType.multiline,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w500,
      ),
      inputFormatters: inputFormatters ?? null, //
      // Apply the custom formatter
      maxLines: maxLines ?? 4,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,

      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.only(left: 20, top: 20),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(.25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),

        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
        suffixIcon: suffixIconn == null
            ? const SizedBox(
                height: 1,
                width: 1,
              )
            : IconButton(
                onPressed: onTap,
                icon: SvgPicture.asset(
                  suffixIconn,
                  fit: BoxFit.none,
                  color: Colors.black,
                ),
              ),
      ),

      obscureText: obscureText ?? false,
      // validator: validator,
    ),
  );
}

SizedBox primaryTextfield4({
  required String hintText,
  required controller,
  var validator,
  int? maxLines,
  String? suffixIconn,
  bool? obscureText,
  VoidCallback? onTap,
  TextInputType? textInputType,
  bool? enabled,
  String? initialValue,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
}) {
  return SizedBox(
    height: 300.ah,
    child: TextFormField(
      cursorColor: Colors.black,
      enabled: enabled ?? true,
      // onTap: onTap,

      maxLength: maxLines,
      initialValue: initialValue,
      keyboardType: textInputType ?? TextInputType.multiline,
      style: TextStyle(
          color: Colors.black,
          height: 1.5,
          fontSize: 15.fSize,
          fontWeight: FontWeight.w500),
      inputFormatters: inputFormatters ?? null, //
      // Apply the custom formatter
      maxLines: maxLines ?? 4,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,

      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.only(left: 20, top: 10),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(.25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),

        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
        suffixIcon: suffixIconn == null
            ? const SizedBox(
                height: 1,
                width: 1,
              )
            : IconButton(
                onPressed: onTap,
                icon: SvgPicture.asset(
                  suffixIconn,
                  fit: BoxFit.none,
                  color: Colors.black,
                ),
              ),
      ),

      obscureText: obscureText ?? false,
      // validator: validator,
    ),
  );
}

SizedBox primaryTextfield5({
  required String hintText,
  required controller,
  var validator,
  int? maxLines,
  String? suffixIconn,
  bool? obscureText,
  VoidCallback? onTap,
  TextInputType? textInputType,
  bool? enabled,
  String? initialValue,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
}) {
  return SizedBox(
    height: 300.ah,
    child: TextFormField(
      cursorColor: Colors.black,
      enabled: enabled ?? true,
      // onTap: onTap,

      maxLength: maxLines,
      initialValue: initialValue,
      keyboardType: textInputType ?? TextInputType.multiline,
      style: TextStyle(
          color: Colors.black,
          height: 1.5,
          fontSize: 15.fSize,
          fontWeight: FontWeight.w500),
      inputFormatters: inputFormatters ?? null, //
      // Apply the custom formatter
      maxLines: maxLines ?? 7,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,

      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.only(left: 20, top: 20),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(.25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),

        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
        suffixIcon: suffixIconn == null
            ? const SizedBox(
                height: 1,
                width: 1,
              )
            : IconButton(
                onPressed: onTap,
                icon: SvgPicture.asset(
                  suffixIconn,
                  fit: BoxFit.none,
                  color: Colors.black,
                ),
              ),
      ),

      obscureText: obscureText ?? false,
      // validator: validator,
    ),
  );
}

SizedBox primaryTextfield6({
  required String hintText,
  required controller,
  var validator,
  int? maxLines,
  String? suffixIconn,
  bool? obscureText,
  VoidCallback? onTap,
  TextInputType? textInputType,
  bool? enabled,
  String? initialValue,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
}) {
  return SizedBox(
    height: 180.ah,
    child: TextFormField(
      cursorColor: Colors.black,
      enabled: enabled ?? true,
      // onTap: onTap,
      maxLength: maxLines,
      initialValue: initialValue,
      keyboardType: textInputType ?? TextInputType.multiline,
      style: TextStyle(
          color: Colors.black,
          height: 1.5,
          fontSize: 15.fSize,
          fontWeight: FontWeight.w500),
      inputFormatters: inputFormatters ?? null, //
      // Apply the custom formatter
      maxLines: maxLines ?? 7,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,

      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.only(left: 20, top: 20),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(.25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),

        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
        suffixIcon: suffixIconn == null
            ? const SizedBox(
                height: 1,
                width: 1,
              )
            : IconButton(
                onPressed: onTap,
                icon: SvgPicture.asset(
                  suffixIconn,
                  fit: BoxFit.none,
                  color: Colors.black,
                ),
              ),
      ),

      obscureText: obscureText ?? false,
      // validator: validator,
    ),
  );
}

SizedBox primaryTextfield7({
  required String hintText,
  required controller,
  required suffix,
  var validator,
  int? maxLines,
  String? suffixIconn,
  String? prefixxx,
  bool? obscureText,
  VoidCallback? onTap,
  TextInputType? textInputType,
  bool? enabled,
  String? initialValue,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
}) {
  return SizedBox(
    height: 58.ah,
    child: TextFormField(
      cursorColor: Colors.black,
      enabled: enabled ?? true,
      // onTap: onTap,

      maxLength: maxLines,
      initialValue: initialValue,
      keyboardType: textInputType ?? TextInputType.multiline,
      style: TextStyle(
          color: Colors.black,
          height: 1.5,
          fontSize: 15.fSize,
          fontWeight: FontWeight.w500),
      inputFormatters: inputFormatters ?? null, //
      // Apply the custom formatter
      maxLines: maxLines ?? 7,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,

      decoration: InputDecoration(
        isDense: true,
        counterText: "",
        contentPadding: EdgeInsets.only(left: 20.h, top: 20.v, bottom: 20.v),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(.25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(39.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(39.h),
          borderSide: BorderSide(
            color: HexColor('#808080'),
            width: 1,
          ),
        ),
        errorStyle: TextStyle(color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(39.h),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(39.h),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),

        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.50),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 16),
        prefixIcon: SvgPicture.asset(
          'assets/icons/Vector (6).svg',
          height: 5.ah,
          width: 6.aw,
          fit: BoxFit.fill,
        ),


        //Icon(Icons.emoji_emotions_outlined,size: 28,color: Colors.black.withOpacity(0.50),),

        suffixIcon: Image.asset(
          'assets/image/Group 2235.png',
          height: 46.ah,
          width: 46.aw,
          fit: BoxFit.fill,
        ),
        // suffixIconn == null ?  SizedBox(height: 28.ah, width: 28.aw,)
        //     : IconButton(
        //       onPressed: onTap,
        //      icon: Icon(Icons.emoji_emotions_outlined),
        // ),
      ),

      obscureText: obscureText ?? false,
      // validator: validator,
    ),
  );
}
