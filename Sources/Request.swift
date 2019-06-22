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
