/// Abstract base class for stream use cases.
/// A stream use case is a piece of code that performs a specific operation on a stream of data.
/// It can be used to filter, transform, or aggregate the data, or to perform any other operation that is required.
/// This abstract class provides a basic interface for all stream use cases. It declares a single method, call(),
/// which must be implemented by all subclasses. The call() method takes a single parameter, param,
/// which is a generic type that represents the parameters required by the stream use case.
/// To use a stream use case, simply create a new instance of the subclass that implements the desired functionality.
/// Then, call the call() method, passing in the required parameters. The call() method will return a result of type Type,
/// which represents the output of the stream use case.
/// @param Type The type of the output of the stream use case.
/// @param Params The type of the parameters required by the stream use case.
abstract class StreamUseCase<Type, Params> {
  Type call({required Params param});
}
