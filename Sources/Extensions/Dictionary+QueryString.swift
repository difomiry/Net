import Foundation

public extension Dictionary where Key == String, Value == Any {

  /// The query string.
  public var queryString: String? {
    return URLComponents(with: queryItems).query
  }

  /// The query items.
  public var queryItems: [URLQueryItem] {
    return self.map { item -> URLQueryItem in
      return URLQueryItem(name: item.key, value: encode(string: "\(item.value)"))
    }
  }

  fileprivate func encode(string: String) -> String {
    return string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }

}

fileprivate extension URLComponents {

  init(with queryItems: [URLQueryItem]) {
    self.init()
    self.queryItems = queryItems
  }

}
