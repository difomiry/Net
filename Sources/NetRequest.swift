
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

    urlComponents.queryItems = target.parameters?.map { (key, value) in
      return URLQueryItem(
        name: key,
        value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
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

    target.headers?.forEach { (key, value) in
      return urlRequest.addValue(value, forHTTPHeaderField: key)
    }

    urlRequest.httpMethod = target.method.rawValue

    return urlRequest
  }

}
