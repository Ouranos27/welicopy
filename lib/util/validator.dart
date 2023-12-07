class Validators {
  static final RegExp _phoneRegex = RegExp(r'(\+84|0)\d{9}$');

  static final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  String checkPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return "Please input phone";
    } else if (!_phoneRegex.hasMatch(phoneNumber)) {
      return "phone not invalid";
    } else {
      return '';
    }
  }

  String checkEmail(String email) {
    if (email.isEmpty) {
      return "please input email";
    } else if (!_emailRegex.hasMatch(email)) {
      return "email not valid";
    } else {
      return '';
    }
  }

  String checkPass(String password) {
    int length = 6;
    if (password.isEmpty) {
      return "please input pass";
    } else if (password.length < length) {
      return "password not invalid";
    } else {
      return "";
    }
  }
}
