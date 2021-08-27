abstract class Failure {}

class ReadWriteException extends Failure {}

class PermissionException extends Failure {}

class NotFoundFailure extends Failure {}

extension FailureExtension on Failure {
  String get toMessage {
    switch (this.runtimeType) {
      case ReadWriteException:
        return 'Can not Read/Write on Storage';
      case PermissionException:
        return 'No Permission';
      case NotFoundFailure:
        return 'Not Found';
      default:
        return 'Unexpected Error';
    }
  }
}
