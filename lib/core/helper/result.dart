sealed class Result<T> {
  const Result();

  /// Executes a callback based on the [Result] type.
  ///
  /// This method allows for convenient pattern matching on the [Result]
  /// without needing explicit `is` checks or type casting.
  R when<R>({
    required R Function(Success<T> success) success,
    required R Function(Failure<T> failure) failure,
  }) {
    if (this is Success<T>) {
      return success(this as Success<T>);
    } else if (this is Failure<T>) {
      return failure(this as Failure<T>);
    }
    // This should ideally not be reached with a sealed class
    // but added for completeness or if 'Result' is not sealed.
    throw StateError('Unknown Result type');
  }
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Success<T> && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'Success(data: $data)';
}

class Failure<T> extends Result<T> {
  final dynamic error; // Can be a String, Exception, or custom error object
  final StackTrace? stackTrace; // Optional stack trace for debugging

  const Failure(this.error, [this.stackTrace]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure<T> &&
        other.error == error &&
        other.stackTrace == stackTrace;
  }

  @override
  int get hashCode => Object.hash(error, stackTrace);

  @override
  String toString() => 'Failure(error: $error, stackTrace: $stackTrace)';
}
