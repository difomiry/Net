import Foundation

/// An alias for the parameters dictionary.
public typealias Parameters = [String: Any]

/// An alias for the headers dictionary.
public typealias Headers = [String: Any]

/// Describes the common request attributes.
public protocol Requestable: URLConvertible, URLRequestConvertible {

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

public extension URLConvertible where Self: Requestable {

  /// Builds the `URL`.
  ///
  /// - Throws: Any error thrown while building the `URL`.
  /// - Returns: The builded `URL`.
  public func toURL() throws -> URL {

    var url = try baseURL.toURL()

    if let path = path {
      url.appendPathComponent(path)
    }

    var urlComponents = try URLComponents(url: url) ??? Error.invalidPath(path: path ?? "")

    var parameters: Parameters = self.parameters ?? [:]

    if let credentials = credentials, case let .apiKey(key, value) = credentials {
      parameters[key] = value
    }

    urlComponents.queryItems = try parameters.toQueryItems()

    return try urlComponents.toURL()
  }

}

public extension URLRequestConvertible where Self: Requestable {

  /// Builds the `URLRequest`.
  ///
  /// - Throws: Any error thrown while building the `URLRequest`.
  /// - Returns: The builded `URLRequest`.
  public func toURLRequest() throws -> URLRequest {

    var urlRequest = URLRequest(url: try toURL())

    urlRequest.httpBody = body

    headers?.forEach { (key, value) in urlRequest.addValue("\(value)", forHTTPHeaderField: key) }

    func addAuthorizationHeader(value: String) {
      urlRequest.addValue(value, forHTTPHeaderField: "Authorization")
    }

    if let credentials = credentials {
      switch credentials {
      case .apiKey:
        break
      case let .basicAuthentication(username, password):
        addAuthorizationHeader(value: "Basic \((username + ":" + password).data(using: .utf8)!.base64EncodedString())")
      case let .bearerAuthentication(token):
        addAuthorizationHeader(value: "Bearer \(token)")
      }
    }

    urlRequest.httpMethod = method.rawValue

    return urlRequest
  }

}

fileprivate extension URLComponents {

  init?(url: URL) {
    self.init(url: url, resolvingAgainstBaseURL: true)
  }

}
