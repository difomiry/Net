/// Provides a success or failure.
public enum Result<Value, Error: Swift.Error> {

  /// A success of a generic type `Value`.
  case success(Value)

  /// A failure with a generic type `Error`.
  case failure(Error)

}
