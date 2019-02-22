/// Provides the common authentication ways.
public enum Credentials {

  /// An API key.
  case apiKey(key: String, value: String)

  /// A basic authentication.
  case basicAuthentication(username: String, password: String)

  /// A bearer authentication.
  case bearerAuthentication(token: String)

}
