String extractRealisasiId(String input) {
  List<String> parts = input.split('GC/');
  if (parts.length > 1) {
    String desiredSubstring = parts[1];
    return desiredSubstring;
  }
  return '';
}
