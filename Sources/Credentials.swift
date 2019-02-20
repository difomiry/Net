
public enum Credentials {
  case apiKey(String, String)
  case basicAuthentication(String, String)
  case bearerAuthentication(String)
}
