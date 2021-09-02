import 'package:flutter/foundation.dart';

enum AccountType {
  WhatsApp,
  WhatsAppBusiness,
}

extension AccountTypeExtension on AccountType {
  String get name => describeEnum(this);

  String get value {
    switch (this) {
      case AccountType.WhatsApp:
        return 'WhatsApp';
      case AccountType.WhatsAppBusiness:
        return 'WhatsApp Business';
      default:
        return 'not found';
    }
  }

  bool isOf(AccountType accountType) {
    return this == accountType;
  }

  String get imagePath {
    switch (this) {
      case AccountType.WhatsApp:
        return 'assets/icons/wa.png';
      case AccountType.WhatsAppBusiness:
        return 'assets/icons/wab.png';
      default:
        return 'assets/icons/not-found.png';
    }
  }

  String get saturatedImagePath {
    switch (this) {
      case AccountType.WhatsApp:
        return 'assets/icons/wa-x.png';
      case AccountType.WhatsAppBusiness:
        return 'assets/icons/wab-x.png';
      default:
        return 'assets/icons/not-found.png';
    }
  }
}
