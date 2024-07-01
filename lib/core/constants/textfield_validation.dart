class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Add more password strength checks as needed
    return null;
  }

  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    // You can add more specific validation rules for first name if needed
    return null;
  }


  static String? validateFullName(String? value) {
    bool _isAlpha(String str) {
      return RegExp(r'^[a-zA-Z]+$').hasMatch(str);
    }
    if (value==null||value.isEmpty) {
      return 'Please enter your full name';
    }
    // Split the full name into parts
    List<String> parts = value.split(' ');
    if (parts.length < 2) {
      return 'Please enter both first name and last name';
    }
    // Check if each part is valid (contains only alphabetical characters)
    for (String part in parts) {
      if (!_isAlpha(part)) {
        return 'Please enter a valid full name';
      }
    }
    return null;

  }


  static String? enterYourState(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your state';
    }
    // You can add more specific validation rules for first name if needed
    return null;
  }



  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field must not be empty';
    }
    // You can add more specific validation rules for first name if needed
    return null;
  }

  static String? enterYourAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    // You can add more specific validation rules for first name if needed
    return null;
  }

  static String? enterhouseHoldIncome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your house Hold Income';
    }
    // You can add more specific validation rules for first name if needed
    return null;
  }
 static String? enterYourZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your zip code';
    }
    // You can add more specific validation rules for first name if needed
    return null;
  }

  static String? enterYourCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your city';
    }
    // You can add more specific validation rules for first name if needed
    return null;
  }


  static String? validateHighSchoolName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your high school name';
    }
    // You can add more specific validation rules for first name if needed
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    // You can add more specific validation rules for last name if needed
    return null;
  }




  static String? validateDouble(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid number';
    }

    // Try parsing the string as a double
    try {
      double doubleValue = double.parse(value);
      // Additional validation rules for double if needed
      // For example, check if it is non-negative
      if (doubleValue < 0) {
        return 'Please enter a non-negative number';
      }
    } catch (FormatException) {
      return 'Please enter a valid number';
    }

    return null;
  }







}
