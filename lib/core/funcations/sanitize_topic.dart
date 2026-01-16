String sanitizeTopic(String email) {
  // Firebase topic names must match [a-zA-Z0-9-_.~%]{1,900}
  // Replace '@' and other invalid characters with '_'
  return email.replaceAll(RegExp(r'[^a-zA-Z0-9-_.~%]'), '_');
}
