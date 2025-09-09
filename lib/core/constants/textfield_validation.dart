import 'package:get/get.dart';

class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'please_enter_your_email'.tr;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'please_enter_a_valid_email'.tr;
    }
    return null;
  }



  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'please_enter_your_password'.tr;
    }

    if (value.length < 8) {
      return 'password_must_be_at_least_8_characters_long'.tr;
    //assword must be at least 8 characters long
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'password_must_contain_at_least_one_uppercase_letter'.tr;
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'password_must_contain_at_least_one_lowercase_letter'.tr;
    }

    // Check for at least one digit
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'password_must_contain_at_least_one_digit'.tr;
    }

    // Check for at least one special character (e.g., !@#$%^&*()_+-=[]{}|;:,.<>?)
    if (!RegExp(r'[!@#$%^&*()_+=-\[\]{}|;:,.<>?]').hasMatch(value)) {
      return 'password_must_contain_at_least_one_special_character'.tr;
    }

    // Add more password strength checks as needed
    return null;

}

  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'field_must_not_be_empty'.tr;
    }
    // You can add more specific validation rules for first name if needed
    return null;
  }

  static String? pleaseWriteSomething(String? value) {
    if (value == null || value.trim().isEmpty ) {
      return 'please_write_something'.tr;
    }
    // You can add more specific validation rules for first name if needed
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'please_enter_your_name'.tr;
    }

    // Split by space and remove empty parts
  //  List<String> parts = value.trim().split(' ').where((e) => e.isNotEmpty).toList();

    // if (parts.length < 2) {
    //   return 'please_enter_your_name'.tr;
    // }

    // No character restrictions — allow special characters
    return null;
  }

}
