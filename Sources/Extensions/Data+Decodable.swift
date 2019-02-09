
import Foundation

public extension Data {

  public func map<T: Decodable>(_ type: T.Type, using decoder: JSONDecoder = .init()) throws -> T {
    return try decoder.decode(type, from: self)
  }

}
