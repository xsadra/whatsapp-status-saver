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
}
