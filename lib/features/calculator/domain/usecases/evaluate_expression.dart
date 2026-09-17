import 'package:math_expressions/math_expressions.dart';
import '../../../../core/constants/app_constants.dart';

class EvaluateExpression {
  String call(String expression) {
    if (expression.isEmpty) return '0';

    try {
      // ফরম্যাটিং ঠিক করা (যেমন: × কে * এবং ÷ কে / এ রূপান্তর করা)
      String sanitizedExpression = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/');

      Parser p = Parser();
      Expression exp = p.parse(sanitizedExpression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval.isInfinite) {
        return AppConstants.errorDivisionByZero;
      }
      if (eval.isNaN) {
        return AppConstants.errorInvalidExpression;
      }

      // যদি দশমিকের পর শুধু ০ থাকে (যেমন 5.0) তবে পূর্ণসংখ্যা দেখাবে (5)
      if (eval == eval.toInt()) {
        return eval.toInt().toString();
      }

      return eval.toString();
    } catch (e) {
      return AppConstants.errorInvalidExpression;
    }
  }
}