
import Foundation

public typealias NetResult = Result<NetResponse, NetError>

public typealias NetCompletion = (NetResult) -> Void

public protocol NetType {
  func request<Request: NetRequestType>(
    _ request: Request,
    completion: @escaping NetCompletion) -> URLSessionDataTask?
}

open class Net: NetType {

  public static let `default` = Net()

  private let session: URLSession
  private let queue: DispatchQueue

  public init(session: URLSession = .shared, queue: DispatchQueue = .main) {
    self.session = session
    self.queue = queue
  }

  @discardableResult
  open func request<Request: NetRequestType>(
    _ request: Request,
    completion: @escaping NetCompletion) -> URLSessionDataTask? {

    func _completion(result: NetResult) {
      self.queue.async {
        completion(result)
      }
    }

    let urlRequest: URLRequest

    do {
      urlRequest = try request.buildURLRequest()
    } catch let error as NetError {
      _completion(result: .failure(error))
      return nil
    } catch {
      _completion(result: .failure(NetError.unknown))
      return nil
    }

    let task = session.dataTask(with: urlRequest) { data, response, error in
      switch (data, response as? HTTPURLResponse, error) {
      case let (.some(data), .some(response), .none):
        if 200..<300 ~= response.statusCode {
          _completion(result: .success(NetResponse(data: data, response: response)))
        } else {
          _completion(result: .failure(NetError.invalidResponseCode(response.statusCode)))
        }
      case let (.none, .none, .some(error)):
        _completion(result: .failure(NetError.invalidResponse(error)))
      default:
        _completion(result: .failure(NetError.unknown))
      }
    }
    task.resume()

    return task
  }

}
