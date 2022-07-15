class CardUtils {
  static bool validateCardByLuhnAlgorithm(String input) {
    int sum = 0;
    final length = input.length;
    for (var i = 0; i < length; i++) {
      int digit = int.parse(input[length - i - 1]);

      if (1 == i % 2) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return true;
    }

    return false;
  }
}
