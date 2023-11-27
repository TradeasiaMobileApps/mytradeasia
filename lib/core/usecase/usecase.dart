/// An abstract base class for use cases.
///
/// A use case is a piece of code that performs a specific operation, such as fetching data from a remote server, saving data to a local database, or processing user input.
///
/// This abstract class provides a basic interface for all use cases. It declares a single method, `call()`, which must be implemented by all subclasses. The `call()` method takes a single parameter, `param`,
/// which is a generic type that represents the parameters required by the use case.
///
/// To use a use case, simply create a new instance of the subclass that implements the desired functionality.
/// Then, call the `call()` method, passing in the required parameters. The `call()` method will return a `Future` of type `Type`,
/// which represents the output of the use case.
///
/// @param Type The type of the output of the use case.
/// @param Params The type of the parameters required by the use case.
abstract class UseCase<Type, Params> {
  /// Performs the use case operation and returns a `Future` of type `Type`, which represents the output of the use case.
  Future<Type> call({required Params param});
}

/// An abstract base class for use cases with two parameters.
///
/// This class extends `UseCase` and provides a specific interface for use cases that require two parameters.
///
/// @param Type The type of the output of the use case.
/// @param A The type of the first parameter required by the use case.
/// @param B The type of the second parameter required by the use case.

abstract class UseCaseTwoParams<Type, A, B> {
  /// Performs the use case operation with the given parameters and returns a `Future` of type `Type`, which represents the output of the use case.
  Future<Type> call({required A paramsOne, required B paramsTwo});
}

/// An abstract base class for use cases with three parameters.
///
/// This class extends `UseCase` and provides a specific interface for use cases that require three parameters.
///
/// @param Type The type of the output of the use case.
/// @param A The type of the first parameter required by the use case.
/// @param B The type of the second parameter required by the use case.
/// @param C The type of the third parameter required by the use case.

abstract class UseCaseThreeParams<Type, A, B, C> {
  /// Performs the use case operation with the given parameters and returns a `Future` of type `Type`, which represents the output of the use case.
  Future<Type> call(
      {required A paramsOne, required B paramsTwo, required C paramsThree});
}

/// An abstract base class for use cases with four parameters.
///
/// This class extends `UseCase` and provides a specific interface for use cases that require four parameters.
///
/// @param Type The type of the output of the use case.
/// @param A The type of the first parameter required by the use case.
/// @param B The type of the second parameter required by the use case.
/// @param C The type of the third parameter required by the use case.
/// @param D The type of the fourth parameter required by the use case.

abstract class UseCaseFourParams<Type, A, B, C, D> {
  /// Performs the use case operation with the given parameters and returns a `Future` of type `Type`, which represents the output of the use case.
  Future<Type> call(
      {required A paramsOne,
      required B paramsTwo,
      required C paramsThree,
      required D paramsFour});
}
