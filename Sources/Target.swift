
import Foundation

public struct Target: TargetType {

  public let baseURLString: String
  public let path: String?
  public let method: HTTPMethod
  public let parameters: Parameters?
  public let body: Data?
  public let headers: Headers?

  public init(
    baseURLString: String,
    path: String? = nil,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    body: Data? = nil,
    headers: Headers? = nil) {
    self.baseURLString = baseURLString
    self.path = path
    self.method = method
    self.parameters = parameters
    self.body = body
    self.headers = headers
  }

}
