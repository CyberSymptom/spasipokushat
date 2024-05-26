extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return replaceFirst(this[0], this[0].toUpperCase());
  }
}
