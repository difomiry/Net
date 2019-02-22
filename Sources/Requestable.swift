import Foundation

/// An alias for the parameters dictionary.
public typealias Parameters = [String: Any]

/// An alias for the headers dictionary.
public typealias Headers = [String: Any]

/// Describes the common request attributes.
public protocol Requestable {

  /// The base `URL`.
  var baseURL: URLConvertible { get }

  /// The path string that appends to the base `URL`.
  var path: String? { get }

  /// The HTTP method.
  var method: HTTPMethod { get }

  /// The query parameters.
  var parameters: Parameters? { get }

  /// The request body.
  var body: Data? { get }

  /// The request headers.
  var headers: Headers? { get }

  /// The request credentials.
  var credentials: Credentials? { get }

}

public extension Requestable {

  /// The empty path.
  public var path: String? {
    return nil
  }

  /// The GET HTTP method.
  public var method: HTTPMethod {
    return .get
  }

  /// The empty query parameters.
  public var parameters: Parameters? {
    return nil
  }

  /// The empty request body.
  public var body: Data? {
    return nil
  }

  /// The empty request headers.
  public var headers: Headers? {
    return nil
  }

  /// The empty request credentials.
  public var credentials: Credentials? {
    return nil
  }

}
