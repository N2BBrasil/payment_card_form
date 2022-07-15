class CpfUtils {
  static String format(String cpf) {
    final numeros = cpf.replaceAll(RegExp('[^0-9]'), '');

    if (numeros.length != 11) return cpf;

    return '${numeros.substring(0, 3)}.${numeros.substring(3, 6)}.${numeros.substring(6, 9)}-${numeros.substring(9)}';
  }

  static bool isValid(String? cpf) {
    if (cpf == null) return false;

    final numeros = cpf.replaceAll(RegExp('[^0-9]'), '');

    if (numeros.length != 11) return false;

    if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) return false;

    final List<int> digitos =
        numeros.split('').map((String d) => int.parse(d)).toList();

    int calcDv1 = 0;
    for (final i in Iterable<int>.generate(9, (i) => 10 - i)) {
      calcDv1 += digitos[10 - i] * i;
    }
    calcDv1 %= 11;
    final dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

    if (digitos[9] != dv1) return false;

    var calcDv2 = 0;
    for (final i in Iterable<int>.generate(10, (i) => 11 - i)) {
      calcDv2 += digitos[11 - i] * i;
    }
    calcDv2 %= 11;
    final dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

    if (digitos[10] != dv2) return false;

    return true;
  }
}
