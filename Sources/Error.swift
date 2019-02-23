/// Provides the error type returned by Net.
public enum Error {

  /// An unknown error.
  case unknown

  /// Returned when an `URLConvertible` type fails to fetch a valid `URL`.
  case invalidURL(url: URLConvertible)

  /// Returned when a path string fails to append to a base `URL`.
  case invalidPath(path: String)

  /// Returned when an `URLSessionDataTask` returns a network error.
  case invalidResponse(error: Swift.Error)

  /// Returned when a string failed to encode.
  case stringEncodingFailed(string: String)

}

extension Error: Swift.Error {

  public var localizedDescription: String {
    switch self {
    case .unknown:
      return "Unknown Error"
    case let .invalidURL(url):
      return "Invalid URL: \(url)"
    case let .invalidPath(path):
      return "Invalid Path: \(path)"
    case let .invalidResponse(error):
      return "Invalid Response:\n\(error.localizedDescription)"
    case let .stringEncodingFailed(string):
      return "String encoding failed: \(string)"
    }
  }

}
