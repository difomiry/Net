import Foundation

public extension Data {

  /// Decodes this data to the decodable type and returns it.
  ///
  /// - Parameters:
  ///   - type: The decodable type.
  ///   - decoder: An instance of `JSONDecoder`.
  /// - Throws: Any error thrown while decoding.
  /// - Returns: An instance of the decodable type.
  func map<T: Decodable>(_ type: T.Type, using decoder: JSONDecoder = .init()) throws -> T {
    return try decoder.decode(type, from: self)
  }

}
