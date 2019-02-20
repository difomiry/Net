
import Foundation

public typealias Parameters = [String: Any]

public typealias Headers = [String: Any]

public protocol TargetType {
  var baseURLString: String { get }
  var path: String? { get }
  var method: HTTPMethod { get }
  var parameters: Parameters? { get }
  var body: Data? { get }
  var headers: Headers? { get }
  var credentials: Credentials? { get }
}

public extension TargetType {

  public var path: String? {
    return nil
  }

  public var method: HTTPMethod {
    return .get
  }

  public var parameters: Parameters? {
    return nil
  }

  public var body: Data? {
    return nil
  }

  public var headers: Headers? {
    return nil
  }

  public var credentials: Credentials? {
    return nil
  }

}
