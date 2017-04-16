
extension SocialNetworkClient {
    
    // MARK: - Constants
    
    struct Constants {
        static let APIScheme = "https"
        static let APIHost = "localhost"
        static let APIPort = 8443
        static let APIPath = "/api"
        static let OAuthPath = "/oauth"
    }
    
    struct OAuth {
        
        enum GrantType {
            case Code, Implicit, ClientCredentials, Password
        }
        
        enum Service {
            case Facebook, Google
        }
        
        struct ParameterKeys {
            static let ClientID = "client_id"
            static let ClientSecret = "client_secret"
            static let AuthorizeURI = "authorize_uri"
            static let TokenURI = "token_uri"
            static let Scope = "scope"
            static let RedirectURIs = "redirect_uris"
            static let SecretInBody = "secret_in_body"
            static let Verbose = "verbose"
            static let Username = "username"
            static let Password = "password"
            static let GrantType = "grant_type"
            static let Service = "service"
        }
        
        struct ParameterValuesGoogle {
            static let ClientID = "GOOGLE_CLIENT_ID"
            static let AuthorizeURI = "https://accounts.google.com/o/oauth2/auth"
            static let TokenURI = "https://www.googleapis.com/oauth2/v3/token"
            static let Scope = "profile"
        }
        
        struct ParameterValuesFacebook {
            
        }
        
        struct ParameterValuesDefault {
            static let ClientID = "clientapp"
            static let ClientSecret = "clientsecret"
            static let AuthorizeURI = "\(Constants.APIScheme)://\(Constants.APIHost):\(Constants.APIPort)\(Constants.OAuthPath)\(Methods.AccessToken)"
        }
    }
    
    // MARK: - Methods
    
    struct Methods {
        static let AccessToken = "/token"
        static let Register = "/register"
        static let Login = "/login"
        static let Logout = "/logout"
    }
    
    // MARK: - Parameters
    
    struct ParameterKeys {
        static let Name = "name"
        static let Email = "email"
        static let Password = "password"
        static let Photo = "photoLink"
        static let Age = "age"
        static let Country = "country"
        static let Gender = "gender"
        static let About = "about"
        static let Online = "online"
    }
    
    struct ParameterValues {
        
    }
    
    enum ServerResponse: String {
        case EmailExists = "\"EMAIL_EXISTS\""
        case UserCreated = "\"USER_CREATED\""
    }
    
    // MARK: - HTTP
    
    struct HTTP {
        struct Methods {
            static let Get = "GET"
            static let Post = "POST"
            static let Delete = "DELETE"
            static let Put = "PUT"
        }
        struct Headers {
            static let Accept = "Accept"
            static let ContentType = "Content-Type"
        }
        struct Types {
            static let JSON = "application/json"
        }
    }
}