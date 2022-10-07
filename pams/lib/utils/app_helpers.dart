import 'package:intl/intl.dart';

class AppHelpers {
  static String greetingMessage() {
    final timeNow = DateTime.now().hour;

    if (timeNow < 12) {
      return 'Good Morning';
    } else if ((timeNow >= 12) && (timeNow < 16)) {
      return 'Good Afternoon';
    } else if ((timeNow >= 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  // static Map<String, dynamic> getCardColor(String type) {
  //   type = type.toLowerCase();
  //   if (type.contains("basic")) {
  //     return {
  //       'color': 0xFF499F68,
  //       'stripe': const Color(0xff71BE8D).withOpacity(0.3),
  //     };
  //   } else if (type.contains("premium")) {
  //     return {
  //       'color': CustomColors.,
  //       'stripe': const Color(0xff4F5050),
  //     };
  //   } else if (type.contains("plus")) {
  //     return {
  //       'color': 0xFFBF871F,
  //       'stripe': const Color(0xffD39B34),
  //     };
  //   } else if (type.contains("exclusive")) {
  //     return {
  //       'color': 0xFF000000,
  //       'stripe': const Color(0xff4F5050),
  //     };
  //   } else if (type.contains("ultra")) {
  //     return {
  //       'color': AppColors.primary.value,
  //       'stripe': const Color.fromARGB(255, 255, 255, 254).withOpacity(0.5),
  //     };
  //   } else if (type.contains("diamond")) {
  //     return {
  //       'color': const Color.fromARGB(249, 161, 161, 161).value,
  //       'stripe': const Color(0xff4F5050),
  //     };
  //   } else {
  //     return {
  //       'color': 0xFF499F68,
  //       'stripe': const Color(0xff71BE8D).withOpacity(0.3),
  //     };
  //   }
  // }

  static final currencyFormatter2 = NumberFormat.simpleCurrency(name: 'NGN', decimalDigits: 2);
  static final currencyFormatter0 = NumberFormat.simpleCurrency(name: 'NGN', decimalDigits: 0);
  static final normalFormatter = '₦${NumberFormat("#,###.##")
    ..minimumFractionDigits = 2
    ..maximumFractionDigits = 2}';
  static final largerNumberFormatter = NumberFormat('##,###,###.00', "en_US");
}

extension StringHelpers on String {
  bool get isPasswordValid => RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%#*?&])[A-Za-z\d@$!#%*?&]{8,15}$").hasMatch(this);
  bool get passwordHasSmallLetters => RegExp(r"^(?=.[a-z])").hasMatch(this);
  bool get passwordHasCapitalLetters => RegExp(r"^(?=.[A-Z])").hasMatch(this);
  bool get passwordHasSymbols => RegExp(r"^(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]").hasMatch(this);
  bool get passwordHasNumber => RegExp(r"^(?=.*\d){8,15}$").hasMatch(this);
  String toPascalCase() {
    if (length < 1) {
      return this;
    } else {
      String temp = '';
      for (final String item in split(' ')) {
        temp += "${item[0].toUpperCase()}${item.substring(1).toLowerCase()}${split(' ').indexOf(item) == split(' ').length - 1 ? '' : ' '}";
      }
      return temp;
    }
  }

  String maskMiddle() {
    final List<String> texts = split('');
    if (texts.length < 2) {
      return this;
    } else {
      String temp = '';
      int ind = 0;
      for (final String item in texts) {
        if (ind > 2 && ind < texts.length - 3) {
          temp += '*';
        } else {
          temp += item;
        }
        ind += 1;
      }
      return temp;
    }
  }

  String firstnLast4() {
    final List<String> texts = split('');
    if (texts.length < 8) {
      return this;
    } else {
      return '${substring(0, 4)}...${substring(length - 4, length)}';
    }
  }

  String last4() {
    final List<String> texts = split('');
    if (texts.length < 8) {
      return this;
    } else {
      return '*******${substring(length - 4, length)}';
    }
  }
}
