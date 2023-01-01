import 'package:intl/intl.dart';

extension StringExtension on String {
  String _capitalized() {
    if (isNotEmpty) {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    } else {
      return this;
    }
  }

  String toCapitalized() {
    // return replaceAll(RegExp(' +'), ' ')
    //     .split(' ')
    //     .map((str) => str._capitalized())
    //     .join(' ');
    return toBeginningOfSentenceCase(this) ?? "";
  }

  bool containsIgnoreCase({required String text}) {
    return toLowerCase().contains(text.toLowerCase());
  }
}
