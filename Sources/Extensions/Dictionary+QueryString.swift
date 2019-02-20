import Foundation

public extension Dictionary where Key == String, Value == Any {

  /// The query string from this dictionary.
  public var queryString: String? {
    return URLComponents(with: queryItems).query
  }

  /// The query items from this dictionary.
  public var queryItems: [URLQueryItem] {
    return self.map { item -> URLQueryItem in
      return URLQueryItem(name: item.key, value: encode(string: "\(item.value)"))
    }
  }

  /// Encodes the string.
  ///
  /// - Parameter string: The string.
  /// - Returns: The encoded string.
  fileprivate func encode(string: String) -> String {
    return string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }

}

/// A support extension for `URLComponents` initializing with the query items.
fileprivate extension URLComponents {

  /// Initializes an instance of `URLComponents`.
  ///
  /// - Parameter queryItems: An array of the query items.
  init(with queryItems: [URLQueryItem]) {
    self.init()
    self.queryItems = queryItems
  }

}
