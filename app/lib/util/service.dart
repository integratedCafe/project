import 'package:intl/intl.dart';

class Service {
  formatComma(int num) {
    var nf = NumberFormat('###,###,###,###');
    return nf.format(num);
  }
}
