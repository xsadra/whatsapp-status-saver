abstract class Failure {}

class ReadWriteFailure extends Failure {}

class FileExistsFailure extends Failure {}

class PermissionFailure extends Failure {}

class NotFoundFailure extends Failure {}

extension FailureExtension on Failure {
  String get toMessage {
    switch (this.runtimeType) {
      case ReadWriteFailure:
        return 'Can not Read/Write on Storage';
      case FileExistsFailure:
        return 'File Exists';
      case PermissionFailure:
        return 'No Permission';
      case NotFoundFailure:
        return 'Not Found';
      default:
        return 'Unexpected Error';
    }
  }
}
