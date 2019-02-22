import Foundation

/// Provides a converting to the `URLRequest`.
public protocol URLRequestConvertible {

  /// Converts to the `URLRequest`.
  ///
  /// - Throws: Any error thrown while converting to the `URLRequest`.
  /// - Returns: The converted `URLRequest`.
  func toURLRequest() throws -> URLRequest

}

extension URLRequest: URLRequestConvertible {

  /// Returns `self`.
  public func toURLRequest() throws -> URLRequest {
    return self
  }

}
extension URL: URLRequestConvertible {

  /// Returns an `URLRequest` based on this `URL`.
  public func toURLRequest() throws -> URLRequest {
    return URLRequest(url: self)
  }

}

extension String: URLRequestConvertible {

  /// Returns an `URLRequest` based on this string.
  public func toURLRequest() throws -> URLRequest {
    return try toURL().toURLRequest()
  }

}
