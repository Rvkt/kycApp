String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Username is required';
  } else if (RegExp(r'[a-zA-Z]').hasMatch(value)) {
    return 'Username should not contain alphabets';
  } else if (value.length != 10) {
    return 'Username should have 10 digits';
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  } else if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required';
  } else if (RegExp(r'\s|\d').hasMatch(value)) {
    return 'Name should not contain whitespace or numbers';
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Invalid email format';
  } else {
    return null;
  }
}



