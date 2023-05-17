
class ResponseWrapper<T> {
  final T? data;
  final ResourceStatus status;
  final String? message;

  ResponseWrapper(this.data, this.status, this.message);
}

enum ResourceStatus { Success, Loading, Error }