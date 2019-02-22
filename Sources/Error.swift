/// Provides the error type returned by Net.
public enum Error {

  /// An unknown error.
  case unknown

  /// Returned when an `URLConvertible` type fails to fetch a valid `URL`.
  case invalidURL

  /// Returned when a path string fails to append to a base `URL`.
  case invalidPath

  /// Returned when an `URLSessionDataTask` returns a network error.
  case invalidResponse(Swift.Error)

}

extension Error: Swift.Error {

  public var localizedDescription: String {
    switch self {
    case .unknown:
      return "Unknown Error"
    case .invalidURL:
      return "Invalid URL"
    case .invalidPath:
      return "Invalid Path"
    case let .invalidResponse(error):
      return "Invalid Response:\n\(error.localizedDescription)"
    }
  }

}
