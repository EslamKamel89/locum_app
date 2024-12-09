String? valdiator({
  required String? input,
  required String label,
  required bool isRequired,
  int? minChars,
  int? maxChars,
  bool? isEmail,
}) {
  input = input ?? '';
  if (isRequired && (input.isEmpty)) {
    return '$label is required';
  }
  if (minChars != null && input.length < minChars) {
    return "$label can't be less than $minChars characters ";
  }
  if (maxChars != null && input.length > maxChars) {
    return "$label can't be more than $maxChars characters ";
  }
  if (isEmail != null && isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(input)) {
    return "Email address not valid";
  }
  return null;
}
