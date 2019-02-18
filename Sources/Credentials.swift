
public enum Credentials {
  case apiKey(String)
  case basicAuthentication(String, String)
  case bearerAuthentication(String)
}
