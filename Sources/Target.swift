
import Foundation

public struct Target: TargetType {

  public let baseURLString: String
  public let path: String?
  public let method: HTTPMethod
  public let parameters: Parameters?
  public let body: Data?
  public let headers: Headers?
  public let credentials: Credentials?

  public init(
    baseURLString: String,
    path: String? = nil,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    body: Data? = nil,
    headers: Headers? = nil,
    credentials: Credentials? = nil) {
    self.baseURLString = baseURLString
    self.path = path
    self.method = method
    self.parameters = parameters
    self.body = body
    self.headers = headers
    self.credentials = credentials
  }

}
