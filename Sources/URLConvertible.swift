import Foundation

/// Provides a converting to the `URL`.
public protocol URLConvertible {

  /// Converts to the `URL`.
  ///
  /// - Throws: Any error thrown while converting to the `URL`.
  /// - Returns: The converted `URL`.
  func toURL() throws -> URL

}

extension URL: URLConvertible {

  /// Returns `self`.
  public func toURL() throws -> URL {
    return self
  }

}

extension URLRequest: URLConvertible {

  /// Returns `self.url`.
  public func toURL() throws -> URL {
    guard let url = self.url else {
      throw Error.invalidURL
    }
    return url
  }

}

extension URLComponents: URLConvertible {

  /// Returns `self.url`.
  public func toURL() throws -> URL {
    guard let url = self.url else {
      throw Error.invalidURL
    }
    return url
  }

}

extension String: URLConvertible {

  /// Returns an `URL` based on this string.
  public func toURL() throws -> URL {
    guard let url = URL(string: self) else {
      throw Error.invalidURL
    }
    return url
  }

}
