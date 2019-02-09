
import Foundation

extension String: NetRequestType {

  public func buildURL() throws -> URL {

    guard let url = URL(string: self) else {
      throw NetError.invalidBaseURL
    }

    return url
  }

}
