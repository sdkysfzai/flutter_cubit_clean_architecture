class AuthenticationHelper {
  static String? validateName(String? formData) {
    if (formData == null || formData.isEmpty) {
      return 'This field cannot be empty!';
    }
    if (formData.length > 12) {
      return 'Maximum length is 12 characters';
    }
    return null;
  }

  static String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return 'Email address cannot be empty!';
    }

    String pattern = r'\w+@\w+\.';
    RegExp regEx = RegExp(pattern);
    if (!regEx.hasMatch(formEmail)) return 'Invalid Email Address Format.';
    return null;
  }

  static String? validatePass(String? formPass) {
    if (formPass == null || formPass.isEmpty) {
      return 'Password cannot be empty!';
    }

    if (formPass.length < 6) {
      return 'Password must be atleast 6 characters!';
    }

    return null;
  }
}