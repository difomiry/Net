
public enum NetError {
  case unknown
  case invalidBaseURL
  case invalidPath
  case invalidParameters
  case invalidResponse(Error)
}

extension NetError: Error {

  public var localizedDescription: String {
    switch self {
    case .unknown:
      return "Unknown Error"
    case .invalidBaseURL:
      return "Invalid BaseURL"
    case .invalidPath:
      return "Invalid Path"
    case .invalidParameters:
      return "Invalid Parameters"
    case let .invalidResponse(error):
      return "Invalid Response:\n\(error.localizedDescription)"
    }
  }

}
