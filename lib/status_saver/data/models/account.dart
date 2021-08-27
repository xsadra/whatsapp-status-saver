import 'package:whatsapp_status_saver/status_saver/data/models/account_type.dart';

class Account {
  final AccountType type;
  final Uri uri;

  Account({
    required this.type,
    required this.uri,
  });
}
