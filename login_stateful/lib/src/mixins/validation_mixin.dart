class ValidationMixin {
   String validateEmail(String value) {
    // return null if valid
    // return string (error msg) if invalid
    if (!value.contains('@')) {
      return 'Please provide a valid email';
    }

    return null;
  }

  String validatePassword(String value) {
    if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }

    return null;
  }
}