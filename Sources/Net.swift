import Foundation

/// An alias for the `URLSessionDataTask`.
public typealias Task = URLSessionDataTask

/// An alias for the completion handler.
public typealias Completion = (Result<Response, Error>) -> Void

/// Used to execute the requests.
open class Net {

  public static let `default` = Net()

  /// An instance of `URLSession`.
  private let session: URLSession

  /// An instance of `DispatchQueue`.
  private let queue: DispatchQueue

  /// Inizializes an instance of the `Net`.
  ///
  /// - Parameters:
  ///   - session: An instance of `URLSession`.
  ///   - queue: An instance of `DispatchQueue`.
  public init(session: URLSession = .shared, queue: DispatchQueue = .main) {
    self.session = session
    self.queue = queue
  }

  /// Sends an `URLRequest` to the server and calls a completion handler with the result.
  ///
  /// - Parameters:
  ///   - convertible: An instance that implements the `URLRequestConvertible`.
  ///   - completion: A completion handler with the result.
  /// - Returns: An `URLSessionDataTask`.
  @discardableResult
  open func request(_ convertible: URLRequestConvertible, completion: @escaping Completion) -> Task? {

    func _completion(result: Result<Response, Error>) {
      self.queue.async {
        completion(result)
      }
    }

    let urlRequest: URLRequest

    do {
      urlRequest = try convertible.toURLRequest()
    } catch {
      _completion(result: .failure(error as? Error ?? Error.unknown))
      return nil
    }

    let task = session.dataTask(with: urlRequest) { data, response, error in
      switch (data, response as? HTTPURLResponse, error) {
      case let (.some(data), .some(response), .none):
        _completion(result: .success(Response(request: urlRequest, response: response, data: data)))
      case let (.none, .none, .some(error)):
        _completion(result: .failure(Error.invalidResponse(error)))
      default:
        _completion(result: .failure(Error.unknown))
      }
    }
    task.resume()

    return task
  }

}
