import Foundation

public extension Dictionary where Key == String, Value == Any {

  /// Converts this dictionary to a query string.
  ///
  /// - Throws: An `Error.stringEncodingFailed` error.
  /// - Returns: A query string.
  public func toQueryString() throws -> String {
    return try URLComponents(with: try toQueryItems()).query ??? Error.unknown
  }

  /// Converts this dictionary to the query items.
  ///
  /// - Throws: An `Error.stringEncodingFailed` error.
  /// - Returns: The query items.
  public func toQueryItems() throws -> [URLQueryItem] {
    return try map { (key, value) -> URLQueryItem in
      return URLQueryItem(name: try encode(string: key), value:try encode(string: "\(value)"))
    }
  }

  fileprivate func encode(string: String) throws -> String {
    return try string
      .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ??? Error.stringEncodingFailed(string: string)
  }

}

fileprivate extension URLComponents {

  init(with queryItems: [URLQueryItem]) {
    self.init()
    self.queryItems = queryItems
  }

}
