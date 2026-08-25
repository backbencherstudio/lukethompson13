class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) return "Full name is required";
    return null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return "Email address is required";
    if (!_emailRegex.hasMatch(email)) return "Enter a valid email address";
    return null;
  }

  static String? password(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < minLength) {
      return "Password must be at least $minLength characters";
    }
    return null;
  }

  static String? confirmPassword(String? value, {required String password}) {
    if (value == null || value.isEmpty) return "Please re-enter your password";
    if (value != password) return "Passwords do not match";
    return null;
  }
}
