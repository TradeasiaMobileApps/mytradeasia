import 'package:dio/dio.dart';

/// An abstract class representing the state of data retrieval or manipulation.
///
/// This class encapsulates both the successful result of a data operation, represented by the [data] property,
/// and any potential error that might occur during the operation, represented by the [error] property.
///
/// Subclasses of [DataState] provide specific implementations for successful and failed data states.
///
/// [DataSuccess] represents a successful data retrieval or manipulation operation, holding the retrieved or manipulated data.
/// [DataFailed] represents a failed data operation, holding the error information associated with the failure.
///
/// @param T The type of data associated with the data state.
abstract class DataState<T> {
  /// The retrieved or manipulated data, if the operation was successful.
  final T? data;

  /// The error information, if the operation failed.
  final DioException? error;

  /// Creates a [DataState] instance with optional [data] and [error] values.
  const DataState({this.data, this.error});
}

/// Represents a successful data retrieval or manipulation operation.
///
/// This class extends [DataState] and holds the retrieved or manipulated data in its [data] property.
///
/// @param T The type of data associated with the successful data state.
class DataSuccess<T> extends DataState<T> {
  /// Creates a [DataSuccess] instance with the retrieved or manipulated [data].
  const DataSuccess(T data) : super(data: data);
}

/// Represents a failed data retrieval or manipulation operation.
///
/// This class extends [DataState] and holds the error information associated with the failure in its [error] property.
///
/// @param T The type of data associated with the failed data state.
class DataFailed<T> extends DataState<T> {
  /// Creates a [DataFailed] instance with the [error] information.
  const DataFailed(DioException error) : super(error: error);
}
