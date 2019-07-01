/// Used to store the request, response and data.
public struct Response {

  /// The request sent to the server.
  public let request: URLRequest

  /// The server's response to the request.
  public let response: HTTPURLResponse

  /// The data returned by the server.
  public let data: Data

}
