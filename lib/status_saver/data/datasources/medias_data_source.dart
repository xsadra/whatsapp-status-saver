import 'package:whatsapp_status_saver/status_saver/data/models/account_type.dart';

abstract class MediasDataSource {
  Map<AccountType, List<Uri>> getAccountMedias();
  bool hasWhatsApp();
  bool hasWhatsAppBusiness();
}

class MediasDataSourceImpl implements MediasDataSource {
  @override
  Map<AccountType, List<Uri>> getAccountMedias() {
    // TODO: implement getAccountMedias
    throw UnimplementedError();
  }

  @override
  bool hasWhatsApp() {
    // TODO: implement hasWhatsApp
    throw UnimplementedError();
  }

  @override
  bool hasWhatsAppBusiness() {
    // TODO: implement hasWhatsAppBusiness
    throw UnimplementedError();
  }
}
