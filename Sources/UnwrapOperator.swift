infix operator ???

func ???<T, E: Swift.Error>(value: T?, error: @autoclosure () -> E) throws -> T {
  guard let value = value else {
    throw error()
  }
  return value
}
