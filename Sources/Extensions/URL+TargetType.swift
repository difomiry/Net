
import Foundation

extension URL: TargetType {

  public var baseURLString: String {
    return absoluteString
  }

}
