class Validator {
  // Email validation function
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // You can use a regular expression for email validation
    // Here's a simple example, but you can adjust it to your needs
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email format';
    }

    return null; // Return null if the validation passes
  }

  // Full name validation function
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    // Count the number of spaces in the full name
    final spaceCount = value.split(' ').length - 1;

    // Check if the full name contains more than 3 spaces
    if (spaceCount > 3) {
      return 'Full name should not contain more than 3 spaces';
    }
    // Split the full name into words
    final words = value.split(' ');

    // Check if there are at least two words in the full name
    if (words.length < 2) {
      return 'Full name should contain first name and last name';
    }

    // Check if the full name exceeds the maximum word limit (35)
    if (words.length > 35) {
      return 'Full name should not exceed 35 words';
    }

    return null; // Return null if the validation passes
  }

  // Password validation function
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Check if the password exceeds the maximum length (16)
    if (value.length > 16) {
      return 'Password should not exceed 16 characters';
    }
    // Check if the password exceeds the maximum length (16)
    if (value.length < 8) {
      return 'Password should contain atleast 8 characters';
    }
    // You can add additional checks for password validation if needed
    // For example, checking minimum length, special characters, etc.

    return null; // Return null if the validation passes
  }
}
