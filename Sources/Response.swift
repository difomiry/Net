import Foundation

/// Used to store the request, response and data.
public struct Response {

  /// The request sent to the server.
  let request: URLRequest

  /// The server's response to the request.
  let response: HTTPURLResponse

  /// The data returned by the server.
  let data: Data

}
