String formatNigerianPhoneNumber(String phoneNumber) {
 //Remove all non-digit characters
 String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D+'), '');
 //check if phone starts with zero, if so, prepend '234'
 if(digitsOnly.startsWith('0')){
  digitsOnly = '234${digitsOnly.substring(1)}';
 return '+$digitsOnly';
 }
  digitsOnly = '234$digitsOnly';
 return '+$digitsOnly';
}
