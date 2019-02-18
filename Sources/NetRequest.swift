
import Foundation

public protocol NetRequestType {
  func buildURL() throws -> URL
  func buildURLRequest() throws -> URLRequest
}

public extension NetRequestType {

  public func buildURLRequest() throws -> URLRequest {

    var urlRequest = URLRequest(url: try buildURL())
    urlRequest.httpMethod = HTTPMethod.get.rawValue

    return urlRequest
  }

}

open class NetRequest<Target: TargetType>: NetRequestType {

  private let target: Target

  public init(_ target: Target) {
    self.target = target
  }

  open func buildURL() throws -> URL {

    guard var _url = URL(string: target.baseURLString) else {
      throw NetError.invalidBaseURL
    }

    if let path = target.path {
      _url.appendPathComponent(path)
    }

    guard var urlComponents = URLComponents(url: _url, resolvingAgainstBaseURL: true) else {
      throw NetError.invalidPath
    }

    urlComponents.queryItems = []

    func addQueryItem(key: String, value: String) {
      urlComponents.queryItems?.append(
        URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))
    }

    target.parameters?.forEach { (key, value) in addQueryItem(key: key, value: value) }

    if let credentials = target.credentials, case let Credentials.apiKey(apiKey) = credentials {
      addQueryItem(key: "api_key", value: apiKey)
    }

    guard let url = urlComponents.url else {
      throw NetError.invalidParameters
    }

    return url
  }

  open func buildURLRequest() throws -> URLRequest {

    var urlRequest = URLRequest(url: try buildURL())

    if let body = target.body {
      urlRequest.httpBody = body
    }

    target.headers?.forEach { (key, value) in urlRequest.addValue(value, forHTTPHeaderField: key) }

    func addAuthorizationHeader(value: String) {
      urlRequest.addValue(value, forHTTPHeaderField: "Authorization")
    }

    if let credentials = target.credentials {
      switch credentials {
      case .apiKey(_):
        break
      case let .basicAuthentication(username, password):
        addAuthorizationHeader(value: "Basic \((username + ":" + password).data(using: .utf8)!.base64EncodedString())")
      case let .bearerAuthentication(token):
        addAuthorizationHeader(value: "Bearer \(token)")
      }
    }

    urlRequest.httpMethod = target.method.rawValue

    return urlRequest
  }

}
