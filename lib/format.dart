import 'package:intl/intl.dart';

final _formatter = NumberFormat('##0.000');

extension Formatter on double {
  String format() => _formatter.format(this);
}
