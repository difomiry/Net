import Foundation

/// Used to create the flexible requests.
public struct Request: Requestable {

  /// The base `URL`.
  public let baseURL: URLConvertible

  /// The path string that appends to the base `URL`.
  public let path: String?

  /// The HTTP method.
  public let method: HTTPMethod

  /// The query parameters.
  public let parameters: Parameters?

  /// The request body.
  public let body: Data?

  /// The request headers.
  public let headers: Headers?

  /// The request credentials.
  public let credentials: Credentials?

  /// Initializes an instance of the `Request`.
  ///
  /// - Parameters:
  ///   - baseURL: The base `URL`.
  ///   - path: The path string that appends to the base `URL`.
  ///   - method: The HTTP method.
  ///   - parameters: The query parameters.
  ///   - body: The request body.
  ///   - headers: The request headers.
  ///   - credentials: The request credentials.
  public init(
    baseURL: URLConvertible,
    path: String? = nil,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    body: Data? = nil,
    headers: Headers? = nil,
    credentials: Credentials? = nil) {
    self.baseURL = baseURL
    self.path = path
    self.method = method
    self.parameters = parameters
    self.body = body
    self.headers = headers
    self.credentials = credentials
  }

}

extension Request: URLConvertible {

  /// Builds the `URL`.
  ///
  /// - Throws: Any error thrown while building the `URL`.
  /// - Returns: The builded `URL`.
  public func toURL() throws -> URL {

    var _url = try baseURL.toURL()

    if let path = path {
      _url.appendPathComponent(path)
    }

    guard var urlComponents = URLComponents(url: _url, resolvingAgainstBaseURL: true) else {
      throw Error.invalidPath
    }

    var _parameters: Parameters = parameters ?? [:]

    if let credentials = credentials, case let .apiKey(key, value) = credentials {
      _parameters[key] = value
    }

    urlComponents.queryItems = _parameters.queryItems

    return try urlComponents.toURL()
  }

}

extension Request: URLRequestConvertible {

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
